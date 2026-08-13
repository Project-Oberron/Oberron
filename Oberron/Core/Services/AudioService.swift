//
//  AudioService.swift
//  Oberron
//
//  Created by Muhammad Akbar Reishandy on 13/08/26.
//

import AVFoundation

class AudioService {
	static let shared = AudioService()
	
	private let engine = AVAudioEngine()
	private let environmentNode = AVAudioEnvironmentNode()
	
	private init() {
		let session = AVAudioSession.sharedInstance()
		do {
			try session.setCategory(.playback, mode: .default, options: [.mixWithOthers])
			try session.setActive(true)
		} catch {
			print("WARNING > AudioService: Failed to activate audio session: \(error)")
		}
		
		engine.attach(environmentNode)
		environmentNode.listenerPosition = AVAudio3DPoint(x: 0, y: 0, z: 0)
		
		engine.connect(environmentNode, to: engine.mainMixerNode, format: nil)
		try? engine.start()
		
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(handleConfigurationChange),
			name: .AVAudioEngineConfigurationChange,
			object: engine
		)
		
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(handleInterruption),
			name: AVAudioSession.interruptionNotification,
			object: session
		)
	}
	
	/// Plays an audio item with optional spatial position, volume, looping, and fade-in settings.
	///
	/// - Parameters:
	///   - audioItem: The `AudioItem` for the audio.
	///   - position: The 3D point location for spatial audio processing. Defaults to `(0, 0, 0)`.
	///   - volume: The target playback volume (0.0 to 1.0). Defaults to `1.0`.
	///   - loops: Whether the audio should loop continuously. Defaults to `false`[cite: 1].
	///   - fadeIn: The duration in seconds to fade in the audio volume. Defaults to `0`[cite: 1].
	/// - Returns: A `PlaybackHandle` object to control playback volume, stop audio, or await completion[cite: 1].
	@discardableResult
	func play(
		for audioItem: AudioItem,
		position: AVAudio3DPoint = AVAudio3DPoint(x: 0, y: 0, z: 0),
		volume: Float = 1.0,
		loops: Bool = false,
		fadeIn: TimeInterval = 0
	) -> PlaybackHandle {
		guard let url = audioItem.url,
			  let file = try? AVAudioFile(forReading: url) else {
			return PlaybackHandle(stopAction: { _ in })
		}
		
		let player = AVAudioPlayerNode()
		engine.attach(player)
		let format = file.processingFormat
		
		engine.connect(player, to: environmentNode, format: format)
		player.position = position
		player.renderingAlgorithm = .auto
		
		let handle = PlaybackHandle(
			stopAction: { [weak self, weak player] fadeOutTime in
				guard let self = self, let player = player else { return }
				
				if fadeOutTime > 0 {
					self.fadeVolume(of: player, to: 0, duration: fadeOutTime) {
						player.stop()
						self.engine.disconnectNodeOutput(player)
						self.engine.detach(player)
					}
				} else {
					player.stop()
					self.engine.disconnectNodeOutput(player)
					self.engine.detach(player)
				}
			},
			volumeGetter: { [weak player] in
				player?.volume ?? 0
			},
			volumeSetter: { [weak self, weak player] targetVolume, fadeDuration in
				guard let self = self, let player = player else { return }
				
				if fadeDuration > 0 {
					self.fadeVolume(of: player, to: targetVolume, duration: fadeDuration)
				} else {
					player.volume = targetVolume
				}
			}
		)
		
		if loops {
			if let buffer = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: AVAudioFrameCount(file.length)) {
				try? file.read(into: buffer)
				player.scheduleBuffer(buffer, at: nil, options: .loops, completionHandler: nil)
			}
		} else {
			player.scheduleFile(file, at: nil, completionCallbackType: .dataPlayedBack) { _ in
				DispatchQueue.main.async {
					player.stop()
					self.engine.disconnectNodeOutput(player)
					self.engine.detach(player)
					
					handle.markAsFinished()
				}
			}
		}
		
		engine.prepare()
		if !engine.isRunning {
			try? engine.start()
		}
		
		if fadeIn > 0 {
			player.volume = 0
			player.play()
			fadeVolume(of: player, to: volume, duration: fadeIn)
		} else {
			player.volume = volume
			player.play()
		}
		
		return handle
	}
	
	private func fadeVolume(
		of player: AVAudioPlayerNode,
		to targetVolume: Float,
		duration: TimeInterval,
		onComplete: (() -> Void)? = nil
	) {
		let startVolume = player.volume
		let steps = 30 // 30 updates per second
		let stepInterval = duration / Double(steps)
		let volumeStep = (targetVolume - startVolume) / Float(steps)
		
		Task {
			for _ in 0..<steps {
				try? await Task.sleep(nanoseconds: UInt64(stepInterval * 1_000_000_000))
				player.volume += volumeStep
			}
			player.volume = targetVolume
			onComplete?()
		}
	}
	
	// Handle hardware playback change
	@objc private func handleConfigurationChange(_ note: Notification) {
		if !engine.isRunning {
			try? engine.start()
		}
	}
	
	// Handle interruption like call
	@objc private func handleInterruption(_ note: Notification) {
		guard let info = note.userInfo,
			  let typeValue = info[AVAudioSessionInterruptionTypeKey] as? UInt,
			  let type = AVAudioSession.InterruptionType(rawValue: typeValue) else { return }
		
		switch type {
		case .began:
			break
		case .ended:
			guard let optionsValue = info[AVAudioSessionInterruptionOptionKey] as? UInt else { return }
			let options = AVAudioSession.InterruptionOptions(rawValue: optionsValue)
			if options.contains(.shouldResume) {
				try? AVAudioSession.sharedInstance().setActive(true)
				try? engine.start()
			}
		@unknown default:
			break
		}
	}
}

/// A handle providing control over an active audio playback session.
final class PlaybackHandle {
	private let stopAction: (_ fadeOut: TimeInterval) -> Void
	private let volumeGetter: () -> Float
	private let volumeSetter: (_ target: Float, _ fadeDuration: TimeInterval) -> Void
	private var completionContinuation: CheckedContinuation<Void, Never>?
	
	/// The current playback volume.
	var volume: Float {
		volumeGetter()
	}
	
	init(
		stopAction: @escaping (TimeInterval) -> Void,
		volumeGetter: @escaping () -> Float = { 0 },
		volumeSetter: @escaping (Float, TimeInterval) -> Void = { _, _ in }
	) {
		self.stopAction = stopAction
		self.volumeGetter = volumeGetter
		self.volumeSetter = volumeSetter
	}
	
	/// Suspends execution asynchronously until playback finishes.
	func waitUntilFinished() async {
		await withCheckedContinuation { continuation in
			self.completionContinuation = continuation
		}
	}
	
	/// Stops audio playback.
	///
	/// - Parameter fadeOut: The duration in seconds over which to fade out audio before stopping. Defaults to `0`.
	func stop(fadeOut: TimeInterval = 0) {
		stopAction(fadeOut)
		markAsFinished()
	}
	
	/// Sets the playback volume[cite: 1].
	///
	/// - Parameters:
	///   - target: The target volume level (0.0 to 1.0).
	///   - fade: The duration in seconds over which to transition to the target volume. Defaults to `0`.
	func setVolume(_ target: Float, fade: TimeInterval = 0) {
		volumeSetter(target, fade)
	}
	
	fileprivate func markAsFinished() {
		completionContinuation?.resume()
		completionContinuation = nil
	}
}

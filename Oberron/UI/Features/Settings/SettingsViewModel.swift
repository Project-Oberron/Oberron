//
//  SettingsViewModel.swift
//  Oberron
//
//  Created by Muhammad Akbar Reishandy on 24/08/26.
//

import Observation
import AVFoundation

@MainActor
@Observable
class SettingsViewModel {
	var isPlaying: Bool = false
	
	private var narrationHandle: PlaybackHandle?
	private var soundHandles: [PlaybackHandle] = []
	private let preferences = PreferenceService.shared
	
	private let soundPool: [AudioItem] = [
		.animalBirds,
		.animalCrickets,
		.craftsWriting,
		.everydayClock,
		.itemsWindChimes,
		.natureRain,
		.natureStream
	]
	
	// MARK: - Playback Control
	func togglePreview() {
		if isPlaying {
			stopPreview()
		} else {
			startPreview()
		}
	}
	
	func startPreview() {
		stopPreview()
		isPlaying = true
		
		narrationHandle = AudioService.shared.play(
			for: .narrationSample,
			volume: preferences.narrationVolume,
			loops: true,
			fadeIn: 0.5
		)
		
		let selectedSounds = soundPool.shuffled().prefix(3)
		for sound in selectedSounds {
			let handle = AudioService.shared.play(
				for: sound,
				position: generateRandomCoordinates(),
				volume: preferences.soundVolume,
				loops: true,
				fadeIn: 1.0
			)
			soundHandles.append(handle)
		}
	}
	
	func stopPreview() {
		guard isPlaying else { return }
		isPlaying = false
		
		narrationHandle?.stop(fadeOut: 0.3)
		narrationHandle = nil
		
		soundHandles.forEach { $0.stop(fadeOut: 0.3) }
		soundHandles.removeAll()
	}
	
	// MARK: - Live Volume Updates
	func updateNarrationVolume(_ volume: Float) {
		narrationHandle?.setVolume(volume)
	}
	
	func updateSoundVolume(_ volume: Float) {
		soundHandles.forEach { $0.setVolume(volume) }
	}
	
	// MARK: - Helpers
	private func generateRandomCoordinates() -> AVAudio3DPoint {
		let distance = Float.random(in: 1.5...3.0)
		let angle = Float.random(in: 0...360)
		let radians = angle * .pi / 180
		
		return AVAudio3DPoint(
			x: sin(radians) * distance,
			y: 0,
			z: cos(radians) * distance
		)
	}
}

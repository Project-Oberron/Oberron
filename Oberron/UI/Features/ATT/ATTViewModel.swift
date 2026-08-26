//
//  ATTViewModel.swift
//  Oberron
//
//  Created by Muhammad Akbar Reishandy on 11/08/26.
//

/*
 TODO LIST:
 1. Change NatureWater audio. Sounds like a toilet flushing and is unpleasant. Temporarily being replaced by adding another chance to get water stream.
 */

import Observation
import AVFoundation

@MainActor
@Observable
class ATTViewModel {
	private var activePrompts: [AudioPrompt] = []
	private let preferences = PreferenceService.shared
	
	// Variables to Randomly Select
	private var animals: AudioItem = .animalDuck
	private var crafts: AudioItem = .craftsWriting
	private var everyday: AudioItem = .everydayClock
	private var items: AudioItem = .itemsDiceRoll
	private var nature: AudioItem = .natureRain
	private var machinery: AudioItem = .machineryRunway
	
	var isDone: Bool = false
	
	private(set) var currentSound: String = "Focus"
	
	// MARK: - BEGIN PLAY
	func start() async {
		isDone = false
		
		setRandomSounds()
		
		// MARK: - AUDIO PLAYERS
		await playNarration(for: .attStart)
		
		// Create Audio Services
		var audioHandles: [PlaybackHandle] = []
		for prompt in activePrompts {
			if let sound = prompt.sound {
				audioHandles.append(
					AudioService.shared.play(
						for: sound,
						position: generateRandomCoordinates(for: prompt),
						volume: preferences.soundVolume,
						loops: true,
						fadeIn: 1.0
					)
				)
			}
		}
		
		// MARK: - NARRATION TIMING
		// Stage 1 Selective Attention
		await doSelective(
			durationSecond: preferences.sessionDuration.selectiveRapidDurationSeconds
		)
		
		// Stage 2 Rapid Attention Switching (w transition sound)
		await doRapid(
			durationSecond: preferences.sessionDuration.selectiveRapidDurationSeconds
		)
		
		// Stage 3 Divided Attention (w transition sound)
		await doDivided(
			durationSecond: preferences.sessionDuration.dividedDurationSeconds
		)
		
		await playNarration(for: .attComplete)
		isDone = true
		
		// Stop Audio
		audioHandles.forEach { handle in
			handle.stop(fadeOut: 2.0)
		}
	}
	
	// MARK: - PHASE 1
	private func doSelective(durationSecond: Int = 300) async {
		currentSound = "Focus"
		await playNarration(for: .attSelective)
		
		let interval = Double(durationSecond) / Double(activePrompts.count)
		
		for prompt in activePrompts {
			currentSound = prompt.text
			
			await playNarration(for: .attFocus)
			await playNarration(for: prompt.narration)
			
			try? await Task.sleep(for: .seconds(max(0, interval - 1.5)))
		}
	}
	
	// MARK: - PHASE 2
	private func doRapid(durationSecond: Int = 300) async {
		currentSound = "Focus"
		await playNarration(for: .attRapid)
		
		let totalDuration = Double(durationSecond)
		var elapsedTime: Double = 0.0
		
		let startInterval = totalDuration / Double(activePrompts.count)
		// Minimum interval dynamically scaled. (e.g., 10s for a 300s total duration).
		let minInterval = 10.0 * (totalDuration / 300.0)
		// Calculate the estimated number of loops using Arithmetic Progression
		let estimatedSteps = (2.0 * totalDuration) / (
			startInterval + minInterval
		)
		// Calculate the exact decrement needed to land on the minimum at the very end
		let decrement = estimatedSteps > 1 ? (startInterval - minInterval) / (
			estimatedSteps - 1
		) : 0
		
		var currentInterval = startInterval
		var previousPrompt = activePrompts.last
		
		while elapsedTime < totalDuration {
			// Ensure the final sleep doesn't push us past the total duration
			let timeRemaining = totalDuration - elapsedTime
			let timeToSleep = min(currentInterval, timeRemaining)
			
			var nextPrompt = activePrompts.randomElement() ?? activePrompts[0]
			while nextPrompt == previousPrompt && activePrompts.count > 1 {
				nextPrompt = activePrompts.randomElement() ?? activePrompts[0]
			}
			
			previousPrompt = nextPrompt
			currentSound = nextPrompt.text
			
			await playNarration(for: nextPrompt.narration)
			try? await Task.sleep(for: .seconds(timeToSleep))
			
			elapsedTime += timeToSleep
			currentInterval = max(minInterval, currentInterval - decrement)
		}
	}
	
	// MARK: - PHASE 3
	private func doDivided(durationSecond: Int = 120) async {
		currentSound = "All"
		await playNarration(for: .attDivided)
		
		try? await Task.sleep(for: .seconds(durationSecond))
	}
	
	// MARK: - AUDIO RANDOMLY SELECT
	private func setRandomSounds() {
		// Animals (45° - 90°)
		let animalOptions: [AudioPrompt] = [
			AudioPrompt(text: "Birds", narration: .animalBirdsNarration, sound: .animalBirds, angleRange: 45...90),
			AudioPrompt(text: "Crickets", narration: .animalCricketsNarration, sound: .animalCrickets, angleRange: 45...90),
			AudioPrompt(text: "Duck", narration: .animalDuckNarration, sound: .animalDuck, angleRange: 45...90)
		]
		
		// Crafts (90° - 135°)
		let craftOptions: [AudioPrompt] = [
			AudioPrompt(text: "Writing", narration: .craftsWritingNarration, sound: .craftsWriting, angleRange: 90...135),
			AudioPrompt(text: "Hammering", narration: .craftsHammeringNarration, sound: .craftsHammering, angleRange: 90...135),
			AudioPrompt(text: "Woodcutting", narration: .craftsWoodcuttingNarration, sound: .craftsWoodcutting, angleRange: 90...135)
		]
		
		// Everyday (225° - 270°)
		let everydayOptions: [AudioPrompt] = [
			AudioPrompt(text: "Clock", narration: .everydayClockNarration, sound: .everydayClock, angleRange: 225...270),
			AudioPrompt(text: "Keychain", narration: .everydayKeychainNarration, sound: .everydayKeychain, angleRange: 225...270),
			AudioPrompt(text: "Paper", narration: .everydayPaperNarration, sound: .everydayPaper, angleRange: 225...270)
		]
		
		// Items (270° - 315°)
		let itemOptions: [AudioPrompt] = [
			AudioPrompt(text: "Dice Roll", narration: .itemsDiceRollNarration, sound: .itemsDiceRoll, angleRange: 270...315),
			AudioPrompt(text: "Wind Chimes", narration: .itemsWindChimesNarration, sound: .itemsWindChimes, angleRange: 270...315),
			AudioPrompt(text: "Church Bell", narration: .itemsChurchBellNarration, sound: .itemsChurchBell, angleRange: 270...315)
		]
		
		// Nature (0° - 45°)
		let natureOptions: [AudioPrompt] = [
			AudioPrompt(text: "Rain", narration: .natureRainNarration, sound: .natureRain, angleRange: 0...45),
			AudioPrompt(text: "Stream", narration: .natureStreamNarration, sound: .natureStream, angleRange: 0...45),
			AudioPrompt(text: "Water", narration: .natureWaterNarration, sound: .natureWater, angleRange: 0...45)
		]
		
		// Machinery (135° - 180°)
		let machineryOptions: [AudioPrompt] = [
			AudioPrompt(text: "Runway", narration: .machineryRunwayNarration, sound: .machineryRunway, angleRange: 135...180),
			AudioPrompt(text: "Ventilation", narration: .machineryVentilationNarration, sound: .machineryVentilation, angleRange: 135...180),
			AudioPrompt(text: "Steam Train", narration: .machinerySteamTrainNarration, sound: .machinerySteamTrain, angleRange: 135...180)
		]
		
		activePrompts = [
			animalOptions.randomElement() ?? animalOptions[0],
			craftOptions.randomElement() ?? craftOptions[0],
			everydayOptions.randomElement() ?? everydayOptions[0],
			itemOptions.randomElement() ?? itemOptions[0],
			natureOptions.randomElement() ?? natureOptions[0],
			machineryOptions.randomElement() ?? machineryOptions[0]
		]
	}
	
	// MARK: GENERATE RANDOM COORDINATES
	private func generateRandomCoordinates(for prompt: AudioPrompt) -> AVAudio3DPoint {
		let distance = Float.random(in: 1.0...3.0)
		let angle = Float.random(in: prompt.angleRange)
		// Turn Angle into Radians for Sin/Cos Function [Radians = degrees × π / 180]
		let radians = angle * .pi / 180
		
		// Convert Angle into Coordinates by Using Sin/Cos
		return AVAudio3DPoint(
			x: sin(radians) * distance,
			y: 0,
			z: cos(radians) * distance
		)
	}
	
	private func playNarration(for audioItem: AudioItem) async {
		await AudioService.shared.play(
			for: audioItem,
			volume: preferences.narrationVolume
		)
		.waitUntilFinished()
	}
}

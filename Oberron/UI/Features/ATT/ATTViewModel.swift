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
	private var randomSound: [String] = []
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
		
		// Set Random Sounds | Audio Items
		var audioItems: [AudioItem] = []
		setRandomSounds(audioArray: &audioItems)
		
		// MARK: - AUDIO PLAYERS
		await playNarration(for: .narrationStart)
		
		// Create Audio Services
		var audioHandles: [PlaybackHandle] = []
		createAudioServices(serviceArray: &audioHandles, audioArray: audioItems)
		
		// Get the 6 random sounds to display
		randomSound = [animals.fileURL, crafts.fileURL, everyday.fileURL, items.fileURL, nature.fileURL, machinery.fileURL]
		
		
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
		
		// TODO: Play the reflection narration
		isDone = true
		
		// Stop Audio
		audioHandles.forEach { handle in
			handle.stop(fadeOut: 2.0)
		}
	}
	
	// MARK: - PHASE 1
	private func doSelective(durationSecond: Int = 300) async {
		currentSound = "Focus"
		// TODO: Selective narration (should be async)
		
		let interval = Double(durationSecond) / Double(randomSound.count)
		
		for sound in randomSound {
			// TODO: Play async narration for this sound
			currentSound = sound
			
			try? await Task.sleep(for: .seconds(interval))
		}
	}
	
	// MARK: - PHASE 2
	private func doRapid(durationSecond: Int = 300) async {
		currentSound = "Focus"
		
		// TODO: Update narration
		await AudioService.shared
			.play(for: .narrationRapidSwitch)
			.waitUntilFinished()
		
		let totalDuration = Double(durationSecond)
		var elapsedTime: Double = 0.0
		
		let startInterval = totalDuration / Double(randomSound.count)
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
		var previousRawSound = randomSound.last ?? ""
		
		while elapsedTime < totalDuration {
			// Ensure the final sleep doesn't push us past the total duration
			let timeRemaining = totalDuration - elapsedTime
			let timeToSleep = min(currentInterval, timeRemaining)
			
			var nextSound = randomSound.randomElement() ?? ""
			while nextSound == previousRawSound && randomSound.count > 1 {
				nextSound = randomSound.randomElement() ?? ""
			}
			
			// TODO: Play async narration for this sound
			previousRawSound = nextSound
			currentSound = nextSound
			
			try? await Task.sleep(for: .seconds(timeToSleep))
			
			elapsedTime += timeToSleep
			currentInterval = max(minInterval, currentInterval - decrement)
		}
	}
	
	// MARK: - PHASE 3
	private func doDivided(durationSecond: Int = 120) async {
		currentSound = "All"
		
		// TODO: Update narration
		await AudioService.shared.play(for: .narrationFinal).waitUntilFinished()
		
		try? await Task.sleep(for: .seconds(durationSecond))
	}
	
	// MARK: - AUDIO RANDOMLY SELECT
	private func setRandomSounds(audioArray: inout [AudioItem]) {
		// Animals Apend
		switch Int.random(in: 0...2) {
		case 0:
			audioArray.append(.animalBirds)
		case 1:
			audioArray.append(.animalCrickets)
		case 2:
			audioArray.append(.animalDuck)
		default: // Find better implementation Later
			audioArray.append(.animalBirds)
		}
		
		// Crafts Apend
		switch Int.random(in: 0...2) {
		case 0:
			audioArray.append(.craftsWriting)
		case 1:
			audioArray.append(.craftsHammering)
		case 2:
			audioArray.append(.craftsWoodcutting)
		default:
			audioArray.append(.craftsWriting)
		}
		
		// Everyday Apend
		switch Int.random(in: 0...2) {
		case 0:
			audioArray.append(.everydayClock)
		case 1:
			audioArray.append(.everydayPaper)
		case 2:
			audioArray.append(.everydayKeychain)
		default:
			audioArray.append(.everydayClock)
		}
		
		// Items Apend
		switch Int.random(in: 0...2) {
		case 0:
			audioArray.append(.itemsDiceRoll)
		case 1:
			audioArray.append(.itemsWindChimes)
		case 2:
			audioArray.append(.itemsChurchBell)
		default:
			audioArray.append(.itemsDiceRoll)
		}
		
		// Nature Apend
		switch Int.random(in: 0...2) {
		case 0:
			audioArray.append(.natureRain)
		case 1:
			audioArray.append(.natureStream)
			//            nature = .natureWater
		case 2:
			audioArray.append(.natureStream)
		default:
			audioArray.append(.natureRain)
		}
		
		// Machinery Apend
		switch Int.random(in: 0...2) {
		case 0:
			audioArray.append(.machineryRunway)
		case 1:
			audioArray.append(.machineryVentilation)
		case 2:
			audioArray.append(.machinerySteamTrain)
		default:
			audioArray.append(.machineryRunway)
		}
		
		print(audioArray)
	}
	
	// MARK: - CREATE AUDIO SERVICES
	private func createAudioServices(serviceArray: inout [PlaybackHandle], audioArray: [AudioItem]) {
		audioArray.forEach { item in
			serviceArray.append(
				AudioService.shared.play(
					for: item,
					position: generateRandomCoordinates(for: item),
					volume: preferences.soundVolume,
					loops: true,
					fadeIn: 1.0
				)
			)
		}
	}
	
	// MARK: GENERATE RANDOM COORDINATES
	private func generateRandomCoordinates(for item: AudioItem) -> AVAudio3DPoint {
		let distance = Float.random(in: 1.0...3.0)
		
		var angle: Float
		var x : Float
		var z: Float
		
		switch item.fileURL {
			// Animals - Front Right
		case "Birds", "Crickets", "Duck":
			angle = Float.random(in: 45...90)
			
			// Crafts - Front Right
		case "Hammering", "Woodcutting", "Writing":
			angle = Float.random(in: 90...135)
			
			// Items - Back Left
		case "Clock", "Keychain", "Paper":
			angle = Float.random(in: 225...270)
			
			// EveryDay - Back Right
		case "Church Bell", "Dice Roll", "Wind Chimes":
			angle = Float.random(in: 270...315)
			
			// Nature - Directly Left
		case "Rain", "Stream", "Water":
			angle = Float.random(in: 0...45)
			
			// Machinery - Directly Right
		case "Runway", "Steam Train", "Ventilation":
			angle = Float.random(in: 135...180)
			
			//
		default:
			angle = Float.random(in: 0...360)
		}
		
		// Turn Angle into Radians for Sin/Cos Function [Radians = degrees × π / 180]
		let radians = angle * .pi / 180
		
		// Convert Angle into Coordinates by Using Sin/Cos
		x = sin(radians) * distance
		z = cos(radians) * distance
		
		//
		return AVAudio3DPoint(x: x, y: 0, z: z)
	}
	
	private func playNarration(for audioItem: AudioItem) async {
		await AudioService.shared.play(
			for: audioItem,
			volume: preferences.narrationVolume
		)
		.waitUntilFinished()
	}
}

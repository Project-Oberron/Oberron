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
	private var randomSound: [String] = [] // TODO: Change to proper audioItem
    
    
    // Variables to Randomly Select
    private var animals: AudioItem = .animalDuck
    private var crafts: AudioItem = .craftsWriting
    private var everyday: AudioItem = .everydayClock
    private var items: AudioItem = .itemsDiceRoll
    private var nature: AudioItem = .natureRain
    private var machinery: AudioItem = .machineryRunway
    
	
	private(set) var currentSound: String = "Focus"
	var isDone: Bool = false // TODO: Debug
	
    // MARK: - BEGIN PLAY
    func start() async {
        isDone = false
        
        // Set Random Sounds
        randomAnimals()
        randomCrafts()
        randomEveryday()
        randomItems()
        randomNature()
        randomMachinery()
        
        // To test audio levels.
        print(animals.fileURL, " ", crafts.fileURL, " ", everyday.fileURL, " ", items.fileURL, " ", nature.fileURL, " ", machinery.fileURL)
        
        
        // MARK: - AUDIO PLAYERS
        await AudioService.shared.play(for: .narrationStart).waitUntilFinished()

        isDone = false

        
        /*
        Current Hard Coded Locations [x = Left, Right | y = Up, Down | z = Forward, Backward]
        Front:
        Nature - (1,3)
        Machinery - (-1,3)

        Side:
        Animals - (3,2)
        Crafts - (-3,2)

        Back:
        Everyday - (2,-3)
        Items - (-2,-3)
        */
        // Animal Audio Player
        let animalsHandle = AudioService.shared.play(
            for: animals,
            position: AVAudio3DPoint(x: 3, y: 0, z: 2),
            loops: true,
            fadeIn: 1.0
        )
        // Crafts Audio Player
        let craftsHandle = AudioService.shared.play(
            for: crafts,
            position: AVAudio3DPoint(x: -3, y: 0, z: 2),
            volume: 0.4,
            loops: true,
            fadeIn: 2.0
        )
        // Everyday Audio Player
        let everydayHandle = AudioService.shared.play(
            for: everyday,
            position: AVAudio3DPoint(x: 2, y: 0, z: -3),
            volume: 0.4,
            loops: true,
            fadeIn: 2.0
        )
        // Items Audio Player
        let itemsHandle = AudioService.shared.play(
            for: items,
            position: AVAudio3DPoint(x: -2, y: 0, z: 3),
            volume: 0.4,
            loops: true,
            fadeIn: 2.0
        )
        // Nature Audio Player
        let natureHandle = AudioService.shared.play(
            for: nature,
            position: AVAudio3DPoint(x: 1, y: 0, z: 3),
            volume: 0.4,
            loops: true,
            fadeIn: 2.0
        )
        // Machinery Audio Player
        let machineryHandle = AudioService.shared.play(
            for: machinery,
            position: AVAudio3DPoint(x: -1, y: 0, z: 3),
            volume: 0.4,
            loops: true,
            fadeIn: 2.0
        )
            
        // Get the 6 random sounds
        randomSound = [animals.fileURL, crafts.fileURL, everyday.fileURL, items.fileURL, nature.fileURL, machinery.fileURL]
            
            // MARK: - NARRATION TIMING
            // TODO: Start narration and chime, gently bring the sound in
            // Stage 1 Selective Attention
            await doSelective(durationSecond: 10) // TODO: Debug
            
            // Stage 2 Rapid Attention Switching (w transition sound)
            await doRapid(durationSecond: 10) // TODO: Debug
            
            // Stage 3 Divided Attention (w transition sound)
            await doDivided(durationSecond: 2) // TODO: Debug
            
            // TODO: End narration and chime, gently bring the sound out
            
            // TODO: Play the reflection narration
            isDone = true
            
            // TODO: Remove test
            animalsHandle.stop(fadeOut: 2.0)
            craftsHandle.stop(fadeOut: 2.0)
            everydayHandle.stop(fadeOut: 2.0)
            itemsHandle.stop(fadeOut: 2.0)
            natureHandle.stop(fadeOut: 2.0)
            machineryHandle.stop(fadeOut: 2.0)
        
    }
    
	
    // MARK: - PHASE 1
	private func doSelective(durationSecond: Int = 300) async {
		// Start narration (should be async)
		
		let interval = Double(durationSecond) / Double(randomSound.count)
		
		for sound in randomSound {
			// TODO: Play async narration for this sound
			currentSound = sound
			
			try? await Task.sleep(for: .seconds(interval))
		}
	}

    // MARK: - PHASE 2
	private func doRapid(durationSecond: Int = 300) async {
		// TODO: Play the transition sound
		// TODO: Start narration for this
        await AudioService.shared.play(for: .narrationRapidSwitch).waitUntilFinished()
		
		let totalDuration = Double(durationSecond)
		var elapsedTime: Double = 0.0
		
		let startInterval = totalDuration / Double(randomSound.count)
		// Minimum interval dynamically scaled. (e.g., 10s for a 300s total duration).
		let minInterval = 10.0 * (totalDuration / 300.0)
		// Calculate the estimated number of loops using Arithmetic Progression
		let estimatedSteps = (2.0 * totalDuration) / (startInterval + minInterval)
		// Calculate the exact decrement needed to land on the minimum at the very end
		let decrement = estimatedSteps > 1 ? (startInterval - minInterval) / (estimatedSteps - 1) : 0
		
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
		
		// TODO: Play the transition sound
		// TODO: Start narration for this
        await AudioService.shared.play(for: .narrationFinal).waitUntilFinished()
		
		try? await Task.sleep(for: .seconds(durationSecond))
	}
    
    
    // MARK: - AUDIO RANDOMLY SELECT
        
    private func randomAnimals() {
        switch Int.random(in: 0...2) {
        case 0:
            animals = .animalBirds
        case 1:
            animals = .animalCrickets
        case 2:
            animals = .animalDuck
        default: // Find better implementation Later
            animals = .animalBirds
        }
    }
    
    private func randomCrafts() {
        switch Int.random(in: 0...2) {
        case 0:
            crafts = .craftsWriting
        case 1:
            crafts = .craftsHammering
        case 2:
            crafts = .craftsWoodcutting
        default:
            crafts = .craftsWriting
        }
    }
    
    private func randomEveryday() {
        switch Int.random(in: 0...2) {
        case 0:
            everyday = .everydayClock
        case 1:
            everyday = .everydayPaper
        case 2:
            everyday = .everydayKeychain
        default:
            everyday = .everydayClock
        }
    }
    
    private func randomItems() {
        switch Int.random(in: 0...2) {
        case 0:
            items = .itemsDiceRoll
        case 1:
            items = .itemsWindChimes
        case 2:
            items = .itemsChurchBell
        default:
            items = .itemsDiceRoll
        }
    }
    
    private func randomNature() {
        switch Int.random(in: 0...2) {
        case 0:
            nature = .natureRain
        case 1:
//            nature = .natureWater
            nature = .natureStream
        case 2:
            nature = .natureStream
        default:
            nature = .natureRain
        }
    }
    
    private func randomMachinery() {
        switch Int.random(in: 0...2) {
        case 0:
            machinery = .machineryRunway
        case 1:
            machinery = .machineryVentilation
        case 2:
            machinery = .machinerySteamTrain
        default:
            machinery = .machineryRunway
        }
    }
}

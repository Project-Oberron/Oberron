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
        // Set Random Sounds | Audio Items
        var audioItems: [AudioItem] = []
        setRandomSounds(audioArray: &audioItems)
        
        
        // MARK: - AUDIO PLAYERS
        await AudioService.shared.play(for: .narrationStart).waitUntilFinished()
        
        // Create Audio Services
        var audioHandles: [PlaybackHandle] = []
        createAudioServices(serviceArray: &audioHandles, audioArray: audioItems)

        isDone = false
        
        // Get the 6 random sounds to display
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
        
        // Stop Audio
        audioHandles.forEach { handle in
            handle.stop(fadeOut: 2.0)
        }
        
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
                    position: AVAudio3DPoint(x: 0, y: 0, z: 0),
                    loops: true,
                    fadeIn: 1.0
                )
            )
        }
        
    }
    
    
    // MARK: GENERATE RANDOM COORDINATES
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
    
}

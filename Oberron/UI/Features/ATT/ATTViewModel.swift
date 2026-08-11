//
//  ATTViewModel.swift
//  Oberron
//
//  Created by Muhammad Akbar Reishandy on 11/08/26.
//

import Observation

@MainActor
@Observable
class ATTViewModel {
	private var randomSound: [String] = [] // TODO: Change
	
	private(set) var currentInstruction: String = ""
	private(set) var currentSound: String = ""
	private(set) var isDone: Bool = false
	
	func start() async {
		isDone = false
		// TODO: Implement actual sound and narration
		
		// Pick 6 random sound
		// TODO: Actual 6 random sound
		randomSound = ["Chicken", "Rain", "Car", "Chopping", "Bells", "Bong"]
		
		// TODO: Start narration and chime, gently bring the sound in
		// Stage 1 Selective Attention
		await doSelective(durationSecond: 5) // TODO: Debug
		
		// Stage 2 Rapid Attention Switching (w transition sound)
		await doRapid(durationSecond: 5) // TODO: Debug
		
		// Stage 3 Divided Attention (w transition sound)
		await doDivided(durationSecond: 5) // TODO: Debug
		
		// TODO: End narration and chime, gently bring the sound out
		
		// TODO: Play the reflection narration
		isDone = true
	}
	
	private func doSelective(durationSecond: Int = 300) async {
		currentInstruction = "We are doing selective attention."
		// Start narration (should be async)
		
		let interval = Double(durationSecond) / Double(randomSound.count)
		
		for sound in randomSound {
			// TODO: Play async narration for this sound
			currentSound = sound
			
			try? await Task.sleep(for: .seconds(interval))
		}
	}
	
	private func doRapid(durationSecond: Int = 300) async {
		currentInstruction = "We are doing rapid attention switching."
		// TODO: Play the transition sound
		// TODO: Start narration for this
		
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
	
	private func doDivided(durationSecond: Int = 120) async {
		currentInstruction = "We are doing divided attention."
		currentSound = "All"
		
		// TODO: Play the transition sound
		// TODO: Start narration for this
		
		try? await Task.sleep(for: .seconds(durationSecond))
	}
}

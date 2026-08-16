//
//  ReflectionViewModel.swift
//  Oberron
//
//  Created by Muhammad Akbar Reishandy on 12/08/26.
//

import Observation

@MainActor
@Observable
class ReflectionViewModel {
	private var continueSleepSecond: Double = 2.0 // TODO: Debug
	private var instructions: [String] = [ // TODO: Change
		"Why are you here?",
		"Why the elephant?",
		"Why not the ants?"
	]
	private var currentInstructionIndex: Int = 0
	
	private(set) var currentInstruction: String = ""
	private(set) var canContinue: Bool = false
	private(set) var isDone: Bool = false
	
	func proceed() async {
		canContinue = false
		
		// This is for the last item
		if currentInstructionIndex == instructions.count - 1 {
			// TODO: Play narration
			currentInstruction = instructions[currentInstructionIndex]
			
			try? await Task.sleep(for: .seconds(continueSleepSecond))
			canContinue = true
			isDone = true
			
			return
		}
		
		// TODO: Play narration
		currentInstruction = instructions[currentInstructionIndex]
		currentInstructionIndex += 1
		
		try? await Task.sleep(for: .seconds(continueSleepSecond))
		canContinue = true
	}
}

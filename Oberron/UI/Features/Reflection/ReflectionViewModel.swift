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
	private var continueSleepSecond: Double = 10.0
	private var questionSet: [AudioPrompt] = []
	private var currentIndex: Int = 0
	private let preferences = PreferenceService.shared
	
	private(set) var currentQuestion: String = ""
	private(set) var canContinue: Bool = false
	private(set) var isDone: Bool = false
	
	func start() async {
		questionSet = ReflectionQuestion.questionSet
		guard let firstPrompt = questionSet.first else { return }
		
		await playNarration(for: .reflectionStart)
		
		currentQuestion = firstPrompt.text
		await playNarration(for: firstPrompt.narration)
		
		try? await Task.sleep(for: .seconds(continueSleepSecond))
		canContinue = true
	}
	
	func proceed() async {
		canContinue = false
		
		currentIndex += 1
		let prompt = questionSet[currentIndex]
		currentQuestion = prompt.text
		
		await playNarration(for: prompt.narration)
		
		try? await Task.sleep(for: .seconds(continueSleepSecond))
		canContinue = true
		
		if currentIndex == questionSet.count - 1 {
			await playNarration(for: .reflectionComplete)
			isDone = true
		}
	}
	
	private func playNarration(for audioItem: AudioItem) async {
		await AudioService.shared.play(
			for: audioItem,
			volume: preferences.narrationVolume
		)
		.waitUntilFinished()
	}
}

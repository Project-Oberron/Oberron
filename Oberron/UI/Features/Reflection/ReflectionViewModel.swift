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
	private var questionSet: [String] = []
	private var currentIndex: Int = 0
	
	private(set) var currentQuestion: String = ""
	private(set) var canContinue: Bool = false
	private(set) var isDone: Bool = false
	
	func start() async {
		questionSet = ReflectionQuestion.questionSet
		currentQuestion = questionSet[0]
		
		try? await Task.sleep(for: .seconds(continueSleepSecond))
		canContinue = true
	}
	
	func proceed() async {
		canContinue = false
		
		currentIndex += 1
		currentQuestion = questionSet[currentIndex]
		
		try? await Task.sleep(for: .seconds(continueSleepSecond))
		canContinue = true
		
		if currentIndex == questionSet.count - 1 {
			isDone = true
		}
	}
}

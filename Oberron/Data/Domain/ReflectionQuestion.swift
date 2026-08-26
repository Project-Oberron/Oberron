//
//  ReflectionQuestion.swift
//  Oberron
//
//  Created by Muhammad Akbar Reishandy on 26/08/26.
//

enum ReflectionQuestion {
	static let notice: [String] = [
		"What feels different now?",
		"What do you notice now?",
		"How are you feeling now?",
		"What feels clearer?",
		"What has changed?"
	]
	
	static let perspective: [String] = [
		"What feels less urgent now?",
		"Does it feel different from before?",
		"What do you see differently?",
		"Is there more space around it?",
		"What feels easier to hold?"
	]
	
	static let orient: [String] = [
		"What matters next?",
		"What deserves your attention?",
		"What can wait?",
		"What would help now?",
		"What do you want to return to?"
	]
	
	static var questionSet: [String] {
		[
			notice.randomElement() ?? notice[0],
			perspective.randomElement() ?? perspective[0],
			orient.randomElement() ?? orient[0]
		]
	}
}

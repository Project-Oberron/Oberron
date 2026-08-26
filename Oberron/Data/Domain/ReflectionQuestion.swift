//
//  ReflectionQuestion.swift
//  Oberron
//
//  Created by Muhammad Akbar Reishandy on 26/08/26.
//

import Foundation

enum ReflectionQuestion {
	static let notice: [AudioPrompt] = [
		AudioPrompt(text: "What feels different now?", narration: .reflectionNotice1),
		AudioPrompt(text: "What do you notice now?", narration: .reflectionNotice2),
		AudioPrompt(text: "How are you feeling now?", narration: .reflectionNotice3),
		AudioPrompt(text: "What feels clearer?", narration: .reflectionNotice4),
		AudioPrompt(text: "What has changed?", narration: .reflectionNotice5)
	]
	
	static let perspective: [AudioPrompt] = [
		AudioPrompt(text: "What feels less urgent now?", narration: .reflectionPerspective1),
		AudioPrompt(text: "Does it feel different from before?", narration: .reflectionPerspective2),
		AudioPrompt(text: "What do you see differently?", narration: .reflectionPerspective3),
		AudioPrompt(text: "Is there more space around it?", narration: .reflectionPerspective4),
		AudioPrompt(text: "What feels easier to hold?", narration: .reflectionPerspective5)
	]
	
	static let orient: [AudioPrompt] = [
		AudioPrompt(text: "What matters next?", narration: .reflectionOrient1),
		AudioPrompt(text: "What deserves your attention?", narration: .reflectionOrient2),
		AudioPrompt(text: "What can wait?", narration: .reflectionOrient3),
		AudioPrompt(text: "What would help now?", narration: .reflectionOrient4),
		AudioPrompt(text: "What do you want to return to?", narration: .reflectionOrient5)
	]
	
	static var questionSet: [AudioPrompt] {
		[
			notice.randomElement() ?? notice[0],
			perspective.randomElement() ?? perspective[0],
			orient.randomElement() ?? orient[0]
		]
	}
}

//
//  AudioPrompt.swift
//  Oberron
//
//  Created by Muhammad Akbar Reishandy on 26/08/26.
//

import Foundation

struct AudioPrompt: Identifiable, Equatable {
	let id = UUID()
	let text: String
	let narration: AudioItem
	let sound: AudioItem?
	let angleRange: ClosedRange<Float>
	
	init(
		text: String,
		narration: AudioItem,
		sound: AudioItem? = nil,
		angleRange: ClosedRange<Float> = 0...360
	) {
		self.text = text
		self.narration = narration
		self.sound = sound
		self.angleRange = angleRange
	}
}

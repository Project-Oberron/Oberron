//
//  Wave.swift
//  Oberron
//
//  Created by Muhammad Akbar Reishandy on 14/08/26.
//

import SwiftUI

// Waow math....
struct Wave: Shape {
	/// How high the waves go (from center line to crest)
	var amplitude: CGFloat = 20
	/// How many full wave cycles fit across the width
	var frequency: CGFloat = 1
	/// Horizontal shift (modify this later for your rolling animation)
	var phase: CGFloat = 0
	
	func path(in rect: CGRect) -> Path {
		var path = Path()
		let baseline = amplitude
		
		path.move(to: CGPoint(x: 0, y: baseline + amplitude * sin(phase)))
		
		for x in stride(from: 0, through: rect.width, by: 1) {
			let relativeX = x / rect.width
			let sine = sin(relativeX * frequency * 2 * .pi + phase)
			let y = baseline + amplitude * sine
			path.addLine(to: CGPoint(x: x, y: y))
		}
		
		path.addLine(to: CGPoint(x: rect.width, y: rect.height))
		path.addLine(to: CGPoint(x: 0, y: rect.height))
		path.closeSubpath()
		
		return path
	}
}

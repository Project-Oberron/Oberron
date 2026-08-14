//
//  ButtonStyleExtension.swift
//  Oberron
//
//  Created by Muhammad Akbar Reishandy on 14/08/26.
//

import SwiftUI

extension ButtonStyle where Self == ScaleButtonStyle {
	static var bounce: ScaleButtonStyle { ScaleButtonStyle() }
}

struct ScaleButtonStyle: ButtonStyle {
	var scale: CGFloat = 0.8
	var duration: Double = 0.8
	
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.scaleEffect(configuration.isPressed ? scale : 1.0)
			.animation(.easeInOut(duration: duration), value: configuration.isPressed)
	}
}

//
//  ViewExtension.swift
//  Oberron
//
//  Created by Muhammad Akbar Reishandy on 14/08/26.
//

import SwiftUI

extension View {
	func staggeredEntrance(
		isVisible: Bool,
		initialScale: CGFloat = 0.75,
		duration: Double = 1
	) -> some View {
		self.modifier(
			StaggeredEntranceModifier(
				isVisible: isVisible,
				initialScale: initialScale,
				duration: duration
			)
		)
	}
}

struct StaggeredEntranceModifier: ViewModifier {
	let isVisible: Bool
	var initialScale: CGFloat = 0.75
	var duration: Double = 1
	
	func body(content: Content) -> some View {
		content
			.scaleEffect(isVisible ? 1.0 : initialScale)
			.opacity(isVisible ? 1.0 : 0)
			.animation(
				.easeInOut(duration: duration),
				value: isVisible
			)
	}
}

//
//  CustomNavBar.swift
//  Oberron
//
//  Created by Muhammad Akbar Reishandy on 27/08/26.
//

import SwiftUI

struct CustomNavBar<Leading: View, Trailing: View>: View {
	var isVisible: Bool = true
	@ViewBuilder var leading: Leading
	@ViewBuilder var trailing: Trailing
	
	init(
		isVisible: Bool = true,
		@ViewBuilder leading: () -> Leading = { EmptyView() },
		@ViewBuilder trailing: () -> Trailing = { EmptyView() }
	) {
		self.isVisible = isVisible
		self.leading = leading()
		self.trailing = trailing()
	}
	
	var body: some View {
		HStack {
			leading
			Spacer()
			trailing
		}
		.staggeredEntrance(isVisible: isVisible)
	}
}

// Convenience Back Button Initializer
extension CustomNavBar where Leading == NavBackButton, Trailing == EmptyView {
	init(isVisible: Bool = true, onBack: @escaping () -> Void) {
		self.init(
			isVisible: isVisible,
			leading: { NavBackButton(action: onBack) },
			trailing: { EmptyView() }
		)
	}
}

struct NavBackButton: View {
	let action: () -> Void
	var body: some View {
		Button(action: action) {
			Image(systemName: "arrow.left")
				.foregroundStyle(.appPrimary)
				.font(.appButton)
				.frame(width: 48, height: 48)
				.background(.ultraThinMaterial, in: Circle())
				.buttonStyle(.bounce)
		}
		.accessibilityLabel("Back")
		.accessibilityInputLabels(["Back", "Go back", "Dismiss"])
	}
}

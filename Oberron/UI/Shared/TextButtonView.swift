//
//  TextButtonView.swift
//  Oberron
//
//  Created by Muhammad Akbar Reishandy on 14/08/26.
//

import SwiftUI

struct TextButtonView: View {
	let text: String
	let action: () -> Void
	
    var body: some View {
		Button {
			action()
		} label: {
			Text(text)
				.underline()
				.font(.loraButton)
		}
		.buttonStyle(.bounce)
		.buttonStyle(.plain)
    }
}

#Preview {
	TextButtonView(text: "Button") {}
}

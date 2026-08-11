//
//  ATTView.swift
//  Oberron
//
//  Created by Muhammad Akbar Reishandy on 11/08/26.
//

import SwiftUI

struct ATTView: View {
    var body: some View {
		VStack {
			Spacer()
			
			VStack(spacing: 80) {
				Text("Listen to the sound of")
					.font(.title)
				
				RoundedRectangle(cornerRadius: 8)
					.frame(width: 50, height: 50)
					.rotationEffect(.degrees(45))
				
				Text("Object")
					.font(.largeTitle.bold())
			}
			
			Spacer()
			
			NavigationLink("Continue", value: NavRoute.reflection)
				.buttonStyle(.glassProminent)
				.buttonSizing(.flexible)
				.controlSize(.large)
		}
		.padding(20)
		.navigationBarBackButtonHidden(true	)
    }
}

#Preview {
	NavigationStack {
		ATTView()
	}
}

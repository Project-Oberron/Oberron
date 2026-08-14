//
//  HomeView.swift
//  Oberron
//
//  Created by Muhammad Akbar Reishandy on 11/08/26.
//

import SwiftUI

struct HomeView: View {
	@Environment(NavigationService.self) var navService
	
    var body: some View {
		VStack {
			Spacer()
			
			VStack(spacing: 24) {
				Button {
					navService.path.append(NavRoute.att)
				} label: {
					CircleWaveView()
						.shadow(radius: 10)
				}
				.buttonStyle(.bounce)
				
				Text("Tap to begin")
					.font(.loraSecondary)
					.foregroundStyle(.appSecondary)
			}
			
			Spacer()
			
			Text("This app is not a replacement for professional mental health care. If you need professional or urgent support, please seek appropriate help")
				.font(.loraFootnote)
				.foregroundStyle(.appSecondary)
				.multilineTextAlignment(.center)
				.padding(.horizontal, 30)
		}
		.padding(20)
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(.appBackground)
		.toolbar {
			ToolbarItem(placement: .topBarLeading) {
				Button {
					// TODO: About Page
				} label: {
					Image(systemName: "info.circle")
						.foregroundStyle(.appPrimary)
						.font(.loraButton)
				}
				.buttonStyle(.bounce)
			}
			.sharedBackgroundVisibility(.hidden)
			
			ToolbarItem(placement: .topBarTrailing) {
				Button {
					// TODO: Settings Page
				} label: {
					Image(systemName: "gearshape")
						.foregroundStyle(.appPrimary)
						.font(.loraButton)
				}
				.buttonStyle(.bounce)
			}
			.sharedBackgroundVisibility(.hidden)
		}
    }
}

#Preview {
	NavigationStack {
		HomeView()
			.environment(NavigationService())
	}
}

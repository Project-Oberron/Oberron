//
//  HomeView.swift
//  Oberron
//
//  Created by Muhammad Akbar Reishandy on 11/08/26.
//

import SwiftUI

struct HomeView: View {
	@Environment(NavigationService.self) var navService
	
	@State private var isVisible = false
	
	var body: some View {
		VStack {
			HStack {
				Button {
                    exitAndNavigate(to: .about)
				} label: {
					Image(systemName: "info.circle")
						.foregroundStyle(.appPrimary)
						.font(.appPrimary)
				}
				.buttonStyle(.bounce)
				.staggeredEntrance(isVisible: isVisible)
				
				Spacer()
				
				Button {
                    exitAndNavigate(to: .settings)
				} label: {
					Image(systemName: "gearshape")
						.foregroundStyle(.appPrimary)
						.font(.appPrimary)
				}
				.buttonStyle(.bounce)
				.staggeredEntrance(isVisible: isVisible)
			}
			
			Spacer()
			
			VStack(spacing: 24) {
				Button {
					exitAndNavigate(to: .att)
				} label: {
					CircleWaveView()
						.shadow(radius: 10)
				}
				.buttonStyle(.bounce)
				.staggeredEntrance(isVisible: isVisible)
				
				Text("Tap to begin")
					.font(.appSecondary)
					.foregroundStyle(.appSecondary)
					.staggeredEntrance(isVisible: isVisible)
			}
			
			Spacer()
			
			Text("This app is not a replacement for professional mental health care. If you need professional or urgent support, please seek appropriate help")
				.font(.appFootnote)
				.foregroundStyle(.appSecondary)
				.multilineTextAlignment(.center)
				.padding(.horizontal, 30)
				.staggeredEntrance(isVisible: isVisible)
		}
		.padding(20)
		.onAppear {
			isVisible = true
		}
	}
	
	private func exitAndNavigate(to route: NavRoute) {
		isVisible = false
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
			navService.navigate(to: route)
		}
	}
}

#Preview {
	HomeView()
		.environment(NavigationService())
}

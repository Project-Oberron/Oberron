//
//  HomeView.swift
//  Oberron
//
//  Created by Muhammad Akbar Reishandy on 11/08/26.
//

import SwiftUI

struct HomeView: View {
	@Environment(NavigationService.self) var navService
	@Environment(\.scenePhase) private var scenePhase
	
	@State private var isVisible = false
	@State private var isInteractive = false
	@State private var pendingNavigationTask: Task<Void, Never>?
	
	var body: some View {
		VStack {
			CustomNavBar(isVisible: isVisible) {
				Button { exitAndNavigate(to: .about) } label: {
					Image(systemName: "info.circle")
						.foregroundStyle(.appPrimary)
						.font(.appPrimary)
						.buttonStyle(.bounce)
				}
				.accessibilityLabel("About Oberron")
				.accessibilityInputLabels(["About", "Info"])
			} trailing: {
				Button { exitAndNavigate(to: .settings) } label: {
					Image(systemName: "gearshape")
						.foregroundStyle(.appPrimary)
						.font(.appPrimary)
						.buttonStyle(.bounce)
				}
				.accessibilityLabel("Settings")
				.accessibilityInputLabels(["Settings", "Preferences"])
			}
			
			Spacer()
			
			VStack(spacing: 24) {
				Button {
					exitAndNavigate(to: .att)
				} label: {
					CircleWaveView()
						.shadow(radius: 10)
						.buttonStyle(.bounce)
						.staggeredEntrance(isVisible: isVisible)
				}
				.accessibilityLabel("Start ATT Session")
				.accessibilityHint("Begins the Attention Training Technique audio exercise")
				.accessibilityInputLabels(["Start session", "Begin session", "Start", "Play"])
				
				Text("Tap to begin")
					.font(.appSecondary)
					.foregroundStyle(.appSecondary)
					.staggeredEntrance(isVisible: isVisible)
					.accessibilityHidden(true)
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
		.allowsHitTesting(isInteractive)
		.onAppear {
			isVisible = true
			lockInteractionTemporarily()
		}
		.onChange(of: scenePhase) { oldPhase, newPhase in
			if newPhase == .active && oldPhase == .background {
				lockInteractionTemporarily()
			}
		}
		.onDisappear {
			pendingNavigationTask?.cancel()
		}
	}
	
	private func lockInteractionTemporarily() {
		isInteractive = false
		DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
			isInteractive = true
		}
	}
	
	private func exitAndNavigate(to route: NavRoute) {
		guard isInteractive else { return }
		isInteractive = false
		isVisible = false
		
		pendingNavigationTask?.cancel()
		pendingNavigationTask = Task {
			try? await Task.sleep(for: .seconds(1.0))
			guard !Task.isCancelled else { return }
			if navService.currentRoute == .home {
				navService.navigate(to: route)
			}
		}
	}
}

//
//  ReflectionView.swift
//  Oberron
//
//  Created by Muhammad Akbar Reishandy on 11/08/26.
//

import SwiftUI

struct ReflectionView: View {
	@Environment(NavigationService.self) private var navService
	
	@State private var viewModel = ReflectionViewModel()
	@State private var isVisible = false
	@State private var waveOnScreen: Bool = true
	
	var body: some View {
		GeometryReader { geo in
			ZStack(alignment: .bottom) {
				// MARK: - The Wave...
				Color.clear
					.overlay {
						WaveView()
							.frame(height: geo.size.height + 300)
							.offset(y: waveOnScreen ? 0 : geo.size.height + 300)
							.accessibilityHidden(true)
					}
				
				// MARK: - Main center text
				VStack(spacing: 12) {
					Text(viewModel.isDone ? "Thank You" : "Listen to yourself")
						.font(.appSecondary)
						.foregroundStyle(.appSecondary)
						.multilineTextAlignment(.center)
						.staggeredEntrance(isVisible: isVisible)
					
					Text(viewModel.currentQuestion)
						.font(.appPrimary)
						.foregroundStyle(.appPrimary)
						.multilineTextAlignment(.center)
						.staggeredEntrance(isVisible: isVisible)
						.accessibilityLabel("Reflection prompt: \(viewModel.currentQuestion)")
						.accessibilityHeading(.h2)
				}
				.padding(20)
				.frame(maxWidth: .infinity, maxHeight: .infinity)
				.animation(.easeInOut(duration: 1), value: viewModel.currentQuestion)
				
				// MARK: - The buttons
				Group {
					TextButtonView(text: "Done") {
						handleDone()
					}
					.staggeredEntrance(isVisible: (viewModel.isDone && isVisible))
					
					TextButtonView(text: "Continue") {
						handleContinue()
					}
					.disabled(!viewModel.canContinue)
					.staggeredEntrance(isVisible: (viewModel.canContinue && !viewModel.isDone))
				}
				.foregroundStyle(.appPrimary)
				.padding(.bottom, 40)
			}
		}
		.task {
			isVisible = true
			await viewModel.start()
		}
		.onDisappear {
			viewModel.stopBGM(fadeOut: 0.5)
		}
	}
	
	private func handleContinue() {
		Task {
			await viewModel.proceed()
		}
	}
	
	private func handleDone() {
		isVisible = false
		viewModel.stopBGM(fadeOut: 1.5)
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			withAnimation(.easeInOut(duration: 1.0)) {
				waveOnScreen = false
			}
		}
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
			navService.navigate(to: .home)
		}
	}
}

#Preview {
	NavigationStack {
		ReflectionView()
			.environment(NavigationService())
	}
}

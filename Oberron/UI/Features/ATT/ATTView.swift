//
//  ATTView.swift
//  Oberron
//
//  Created by Muhammad Akbar Reishandy on 11/08/26.
//

import SwiftUI

struct ATTView: View {
	@Environment(NavigationService.self) private var navService
	
	@State private var viewModel = ATTViewModel()
	@State private var isVisible = false
	@State private var waveOffset: CGFloat = 200
	
	var body: some View {
		GeometryReader { geo in
			ZStack(alignment: .bottom) {
				// MARK: - Main center text
				VStack(spacing: 12) {
					Text(viewModel.isDone ? "Finished" : "Follow the instructions")
						.font(.appSecondary)
						.foregroundStyle(.appSecondary)
						.multilineTextAlignment(.center)
						.staggeredEntrance(isVisible: isVisible)
					
					Text(viewModel.isDone ? "Now, we’ll take a moment to reflect" : "Keep your eyes open and listen carefully")
						.font(.appPrimary)
						.foregroundStyle(.appPrimary)
						.multilineTextAlignment(.center)
						.staggeredEntrance(isVisible: isVisible)
				}
				.padding(20)
				.frame(maxWidth: .infinity, maxHeight: .infinity)
				.animation(.easeInOut(duration: 1), value: viewModel.isDone)
				
				// MARK: - The navigation buttons
				VStack(spacing: 15) {
					TextButtonView(text: "Continue") {
						handleContinue(screenHeight: geo.size.height)
					}
					.foregroundStyle(.appPrimary)
					
					TextButtonView(text: "Done") {
						handleDone()
					}
					.foregroundStyle(.appSecondary)
				}
				.staggeredEntrance(isVisible: (isVisible && viewModel.isDone))
				.padding(.bottom, 40)
				
				// MARK: - Waves and current sound
				VStack {
					Text(viewModel.currentSound)
						.font(.appHuge)
						.foregroundStyle(.appSecondary)
						.padding(.top, 20)
						.opacity(0.4)
						.staggeredEntrance(isVisible: (isVisible && !viewModel.isDone))
						.animation(.easeInOut(duration: 1), value: viewModel.currentSound)
					
					Spacer()
					
					Color.clear
						.overlay {
							WaveView()
								.frame(height: geo.size.height + 300)
								.offset(y: geo.size.height + waveOffset)
						}
				}
				.ignoresSafeArea(edges: .bottom)
			}
			.task {
				withAnimation(.easeInOut(duration: 1)) {
					isVisible = true
					waveOffset = 0
				}
				
				await viewModel.start()
			}
			.onChange(of: viewModel.isDone) { _, isDone in
				if isDone {
					withAnimation(.easeInOut(duration: 1)) {
						waveOffset = 200
					}
				}
			}
		}
	}
	
	private func handleDone() {
		isVisible = false
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
			navService.navigate(to: .home)
		}
	}
	
	private func handleContinue(screenHeight: CGFloat) {
		withAnimation(.easeInOut(duration: 1.0)) {
			waveOffset = -screenHeight - 150
		}
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			navService.navigate(to: .reflection)
		}
	}
}

#Preview {
	NavigationStack {
		ATTView()
			.environment(NavigationService())
	}
}

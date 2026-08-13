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
	
	var body: some View {
		VStack {
			Spacer()
			
			VStack(spacing: 8) {
				Text("Answer this in your mind")
					.foregroundStyle(.secondary)
				
				Text(viewModel.currentInstruction)
			}
			
			Spacer()
			
			if viewModel.isDone {
				Button("Done") {
					navService.reset()
				}
				.buttonStyle(.glassProminent)
				.buttonSizing(.flexible)
				.controlSize(.large)
			} else {
				Button("Continue") {
					Task {
						await viewModel.proceed()
					}
				}
				.buttonStyle(.glassProminent)
				.buttonSizing(.flexible)
				.controlSize(.large)
				.disabled(!viewModel.canContinue)
			}
		}
		.padding(20)
		.navigationBarBackButtonHidden(true	)
		.task {
			await viewModel.proceed()
		}
	}
}

#Preview {
	NavigationStack {
		ReflectionView()
			.environment(NavigationService())
	}
}

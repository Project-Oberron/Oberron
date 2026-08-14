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
	
    var body: some View {
		VStack {
			if viewModel.isDone { // TODO: Debug
				VStack(spacing: 80) {
					Text(viewModel.currentInstruction)
						.font(.title)
						.multilineTextAlignment(.center)
					
					RoundedRectangle(cornerRadius: 8)
						.frame(width: 50, height: 50)
						.rotationEffect(.degrees(45))
					
					Text(viewModel.currentSound)
						.font(.largeTitle.bold())
				}
			} else {
				Spacer()
				
				VStack(spacing: 12) {
					Text("We are done.")
						.font(.title)
					
					Text("You can continue with reflection")
						.multilineTextAlignment(.center)
				}
				
				Spacer()
				
				NavigationLink("Continue", value: NavRoute.reflection)
					.buttonStyle(.glassProminent)
					.buttonSizing(.flexible)
					.controlSize(.large)
				
				Button("Not Now") {
					navService.navigate(to: .home)
				}
				.buttonStyle(.glass)
				.buttonSizing(.flexible)
				.controlSize(.large)
			}
		}
		.padding(20)
		.navigationBarBackButtonHidden(true	)
		.task {
//			await viewModel.start() // TODO: Debug
			isVisible = true
		}
		.staggeredEntrance(isVisible: isVisible) // TODO: Debug
    }
}

#Preview {
	NavigationStack {
		ATTView()
			.environment(NavigationService())
	}
}

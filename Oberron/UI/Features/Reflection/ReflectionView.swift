//
//  ReflectionView.swift
//  Oberron
//
//  Created by Muhammad Akbar Reishandy on 11/08/26.
//

import SwiftUI

struct ReflectionView: View {
	@Environment(NavigationService.self) private var navService
	
	var body: some View {
		VStack {
			Spacer()
			
			VStack(spacing: 8) {
				Text("Reflect")
					.foregroundStyle(.secondary)
				
				Text("Still placeholder")
					.font(.title.bold())
			}
			
			Spacer()
			
			Button("Done") {
				navService.reset()
			}
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
		ReflectionView()
			.environment(NavigationService())
	}
}

//
//  WaveView.swift
//  Oberron
//
//  Created by Muhammad Akbar Reishandy on 14/08/26.
//

import SwiftUI

struct WaveView: View {
	var body: some View {
		ZStack {
			Wave(amplitude: 30, frequency: 0.8, phase: 4.4)
				.fill(.appGradient3)
				.shadow(radius: 10)
				.offset(y: -75)
			
			Wave(amplitude: 35, frequency: 0.8, phase: 0.3)
				.fill(.appGradient2)
				.shadow(radius: 10)
				.offset(y: -65)
			
			Wave(amplitude: 30, frequency: 0.8, phase: 4.6)
				.fill(.appGradient1)
				.shadow(radius: 10)
				.offset(y: -20)
			
			Wave(amplitude: 25, frequency: 0.8, phase: 0.3)
				.fill(.appSurface)
				.shadow(radius: 10)
		}
	}
}

#Preview {
	VStack {
		Spacer()
		
		WaveView()
			.frame(height: 100)
	}
	.ignoresSafeArea(edges: .bottom)
}

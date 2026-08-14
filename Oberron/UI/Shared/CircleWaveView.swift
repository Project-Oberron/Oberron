//
//  CircleWaveView.swift
//  Oberron
//
//  Created by Muhammad Akbar Reishandy on 14/08/26.
//

import SwiftUI

struct CircleWaveView: View {
	var radius: CGFloat = 300
	
	let baseSize: CGFloat = 300
	
	var body: some View {
		ZStack(alignment: .bottom) {
			Color(.appGradient4)
			
			WaveView()
				.frame(height: baseSize / 3)
		}
		.frame(width: baseSize, height: baseSize)
		.clipShape(Circle())
		.scaleEffect(radius / baseSize)
		.frame(width: radius, height: radius)
		.overlay {
			Image(systemName: "play.circle.fill")
				.foregroundStyle(.white)
				.font(.custom("Circle-Play", size: (radius / 3)))
		}
	}
}

#Preview {
    CircleWaveView()
    CircleWaveView(radius: 200)
}

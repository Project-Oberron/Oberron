//
//  HomeView.swift
//  Oberron
//
//  Created by Muhammad Akbar Reishandy on 11/08/26.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
		VStack {
			Spacer()
			
			Text("Project Oberron")
				.font(.loraPrimary)
			
			NavigationLink("Start ATT", value: NavRoute.att)
				.buttonStyle(.glassProminent)
				.controlSize(.extraLarge)
			
			Spacer()
			
			Text("Disclaimer: This is a quick prototype wihtout any meaningful UI/UX yet to test the functionality of the app.")
				.font(.loraFootnote)
				.multilineTextAlignment(.center)
				.foregroundStyle(.secondary)
				.padding(.horizontal, 50)
		}
		.padding(20)
		.toolbar {
			ToolbarItem(placement: .topBarTrailing) {
				NavigationLink(value: NavRoute.settings) {
					Image(systemName: "gearshape")
				}
			}
		}
    }
}

#Preview {
	NavigationStack {
		HomeView()
	}
}

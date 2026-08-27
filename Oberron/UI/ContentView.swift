//
//  ContentView.swift
//  Oberron
//
//  Created by Muhammad Akbar Reishandy on 08/08/26.
//

import SwiftUI

struct ContentView: View {
	private var preferences = PreferenceService.shared
	
	@State private var navService = NavigationService.shared
	
    var body: some View {
		ZStack {
			Color.appBackground
				.ignoresSafeArea()
			
			switch navService.currentRoute {
			case .home:
				HomeView()
			case .att:
				ATTView()
			case .reflection:
				ReflectionView()
			case .settings:
				SettingsView()
            case .about:
                AboutView()
			}
		}
		.animation(.smooth(duration: 0.35), value: preferences.selectedTheme)
		.animation(.smooth(duration: 0.35), value: preferences.selectedFont)
		.environment(navService)
    }
}

#Preview {
    ContentView()
}

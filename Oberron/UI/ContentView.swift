//
//  ContentView.swift
//  Oberron
//
//  Created by Muhammad Akbar Reishandy on 08/08/26.
//

import SwiftUI

struct ContentView: View {
	@State private var navService = NavigationService.shared
	
	// TODO: Revamp for fixed UI/UX
    var body: some View {
		NavigationStack(path: $navService.path) {
			HomeView()
				.navigationDestination(for: NavRoute.self) { route in
					switch route {
					case .home:
						HomeView()
					case .att:
						ATTView()
					case .reflection:
						ReflectionView()
					case .settings:
						SettingsView()
					}
				}
		}
		.environment(navService)
    }
}

#Preview {
    ContentView()
}

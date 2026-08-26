//
//  OberronApp.swift
//  Oberron
//
//  Created by Muhammad Akbar Reishandy on 08/08/26.
//

import SwiftUI
import AppIntents

@main
struct OberronApp: App {
	@UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
	
	private var preferences = PreferenceService.shared
	
	init() {
		OberronShortcuts.updateAppShortcutParameters()
	}
	
	var body: some Scene {
		WindowGroup {
			ContentView()
				.preferredColorScheme(preferences.selectedTheme.colorScheme)
				.animation(.smooth(duration: 0.5), value: preferences.selectedFont)
				.onChange(of: preferences.selectedTheme) {
					animateThemeChange()
				}
		}
	}
	
	private func animateThemeChange() {
		guard let window = UIApplication.shared.connectedScenes
			.compactMap({ $0 as? UIWindowScene })
			.flatMap({ $0.windows })
			.first(where: { $0.isKeyWindow }) else { return }
		
		UIView.transition(
			with: window,
			duration: 0.5,
			options: .transitionCrossDissolve,
			animations: nil
		)
	}
}

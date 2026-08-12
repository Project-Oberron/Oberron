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
	
	init() {
		OberronShortcuts.updateAppShortcutParameters()
	}
	
	var body: some Scene {
		WindowGroup {
			ContentView()
		}
	}
}

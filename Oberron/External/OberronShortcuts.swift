//
//  OberronShortcuts.swift
//  Oberron
//
//  Created by Muhammad Akbar Reishandy on 12/08/26.
//

import AppIntents

struct OberronShortcuts: AppShortcutsProvider {
	@AppShortcutsBuilder
	static var appShortcuts: [AppShortcut] {
		AppShortcut(
			intent: StartSessionIntent(),
			// TODO: keywords
			phrases: [
				"Start session in \(.applicationName)",
				"Start a session in \(.applicationName)",
				"Start \(.applicationName) session",
				"Begin \(.applicationName) session"
			],
			shortTitle: "Start Session",
			systemImageName: "play.circle.fill" // TODO: Icon and the Info.plist icon
		)
	}
}

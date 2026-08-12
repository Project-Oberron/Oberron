//
//  StartSessionIntent.swift
//  Oberron
//
//  Created by Muhammad Akbar Reishandy on 12/08/26.
//

import AppIntents
import SwiftUI

struct StartSessionIntent: AppIntent {
	static let title: LocalizedStringResource = "Start Session" // TODO: Change, don't forget Info.plist and OberronShortcuts
	static let description = IntentDescription("Quickly start an Oberron session.") // TODO: Wording
	static var openAppWhenRun: Bool = true
	
	func perform() async throws -> some IntentResult {
		await MainActor.run {
			NavigationService.shared.startSession()
		}
		
		return .result()
	}
}

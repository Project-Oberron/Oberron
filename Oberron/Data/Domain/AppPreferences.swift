//
//  AppPreferences.swift
//  Oberron
//
//  Created by Muhammad Akbar Reishandy on 26/08/26.
//

import SwiftUI

enum SessionDuration: String, CaseIterable, Identifiable {
	case short = "6 min"
	case standard = "12 min"
	case long = "24 min"
	
	var id: String { rawValue }
	
	var selectiveRapidDurationSeconds: Int {
		switch self {
		case .short: return 150
		case .standard: return 300
		case .long: return 600
		}
	}
	
	var dividedDurationSeconds: Int {
		switch self {
		case .short: return 60
		case .standard: return 120
		case .long: return 240
		}
	}
}

enum AppFont: String, CaseIterable, Identifiable {
	case system = "System"
	case lora = "Lora"
	case openDyslexic = "OpenDyslexic"
	
	var id: String { rawValue }
	
	func postScriptName(weight: Font.Weight = .regular, isItalic: Bool = false) -> String? {
		switch self {
		case .system:
			return nil
			
		case .lora:
			if isItalic { return "Lora-Italic" }
			if weight == .bold { return "Lora-Regular_Bold" }
			return "Lora-Regular"
			
		case .openDyslexic:
			if isItalic { return "OpenDyslexic-Italic" }
			if weight == .bold { return "OpenDyslexic-Bold" }
			return "OpenDyslexic-Regular"
		}
	}
}

enum AppTheme: String, CaseIterable, Identifiable {
	case system = "System"
	case light = "Light"
	case dark = "Dark"
	
	var id: String { rawValue }
	
	var colorScheme: ColorScheme? {
		switch self {
		case .system: return nil
		case .light: return .light
		case .dark: return .dark
		}
	}
}

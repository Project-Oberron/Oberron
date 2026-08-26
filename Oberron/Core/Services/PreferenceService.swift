//
//  PreferenceService.swift
//  Oberron
//
//  Created by Muhammad Akbar Reishandy on 26/08/26.
//

import SwiftUI

@Observable
final class PreferenceService {
	static let shared = PreferenceService()
	
	private let defaults = UserDefaults.standard
	
	private enum Keys {
		static let narrationVolume = "pref_vol_narration"
		static let soundVolume = "pref_vol_sound"
		static let sessionDuration = "pref_session"
		static let selectedFont = "pref_font"
		static let selectedTheme = "pref_theme"
	}
	
	var narrationVolume: Float {
		didSet {
			defaults.set(narrationVolume, forKey: Keys.narrationVolume)
		}
	}
	
	var soundVolume: Float {
		didSet {
			defaults.set(soundVolume, forKey: Keys.soundVolume)
		}
	}
	
	var sessionDuration: SessionDuration {
		didSet {
			defaults.set(sessionDuration.rawValue, forKey: Keys.sessionDuration)
		}
	}
	
	var selectedFont: AppFont {
		didSet {
			defaults.set(selectedFont.rawValue, forKey: Keys.selectedFont)
		}
	}
	
	var selectedTheme: AppTheme {
		didSet {
			defaults.set(selectedTheme.rawValue, forKey: Keys.selectedTheme)
		}
	}
	
	private init() {
		self.narrationVolume = defaults.object(forKey: Keys.narrationVolume) != nil ? defaults.float(forKey: Keys.narrationVolume) : 0.8
		self.soundVolume = defaults.object(forKey: Keys.soundVolume) != nil ? defaults.float(forKey: Keys.soundVolume) : 0.8
		
		let savedFontRaw = defaults.string(forKey: Keys.selectedFont) ?? "Lora"
		self.selectedFont = AppFont(rawValue: savedFontRaw) ?? .lora
		
		let savedThemeRaw = defaults.string(forKey: Keys.selectedTheme) ?? "System"
		self.selectedTheme = AppTheme(rawValue: savedThemeRaw) ?? .system
		
		let savedDurationRaw = defaults.string(forKey: Keys.sessionDuration) ?? "6 min"
		self.sessionDuration = SessionDuration(rawValue: savedDurationRaw) ?? .standard
	}
}

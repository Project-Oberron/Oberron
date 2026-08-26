//
//  AudioItem.swift
//  Oberron
//
//  Created by Muhammad Akbar Reishandy on 13/08/26.
//

import Foundation

struct AudioItem: Equatable {
	let id = UUID()
	
	let fileURL: String
	let fileExtension: String
	
	var url: URL? {
		guard let url = Bundle.main.url(forResource: self.fileURL, withExtension: self.fileExtension) else {
			print("WARNING > AudioItem: Could not find \(self.fileURL).\(self.fileExtension) in bundle.")
			return nil
		}
		return url
	}
	
	// MARK: - NARRATION
	static let narrationSample = AudioItem(fileURL: "narration_sample", fileExtension: "wav")
	
	// - ATT
	static let attStart = AudioItem(fileURL: "att_start", fileExtension: "wav")
	static let attComplete = AudioItem(fileURL: "att_complete", fileExtension: "wav")
	static let attDivided = AudioItem(fileURL: "att_divided", fileExtension: "wav")
	static let attFocus = AudioItem(fileURL: "att_focus", fileExtension: "wav")
	static let attRapid = AudioItem(fileURL: "att_rapid", fileExtension: "wav")
	static let attSelective = AudioItem(fileURL: "att_selective", fileExtension: "wav")
	
	// - Reflection
	static let reflectionStart = AudioItem(fileURL: "reflection_start", fileExtension: "wav")
	static let reflectionComplete = AudioItem(fileURL: "reflection_complete", fileExtension: "wav")
	
	// MARK: - QUESTIONS
	
	// - Notice
	static let reflectionNotice1 = AudioItem(fileURL: "reflection_notice1", fileExtension: "wav")
	static let reflectionNotice2 = AudioItem(fileURL: "reflection_notice2", fileExtension: "wav")
	static let reflectionNotice3 = AudioItem(fileURL: "reflection_notice3", fileExtension: "wav")
	static let reflectionNotice4 = AudioItem(fileURL: "reflection_notice4", fileExtension: "wav")
	static let reflectionNotice5 = AudioItem(fileURL: "reflection_notice5", fileExtension: "wav")
	
	// - Perspective
	static let reflectionPerspective1 = AudioItem(fileURL: "reflection_perspective1", fileExtension: "wav")
	static let reflectionPerspective2 = AudioItem(fileURL: "reflection_perspective2", fileExtension: "wav")
	static let reflectionPerspective3 = AudioItem(fileURL: "reflection_perspective3", fileExtension: "wav")
	static let reflectionPerspective4 = AudioItem(fileURL: "reflection_perspective4", fileExtension: "wav")
	static let reflectionPerspective5 = AudioItem(fileURL: "reflection_perspective5", fileExtension: "wav")
	
	// - Orient
	static let reflectionOrient1 = AudioItem(fileURL: "reflection_orient1", fileExtension: "wav")
	static let reflectionOrient2 = AudioItem(fileURL: "reflection_orient2", fileExtension: "wav")
	static let reflectionOrient3 = AudioItem(fileURL: "reflection_orient3", fileExtension: "wav")
	static let reflectionOrient4 = AudioItem(fileURL: "reflection_orient4", fileExtension: "wav")
	static let reflectionOrient5 = AudioItem(fileURL: "reflection_orient5", fileExtension: "wav")
	
	// MARK: - SOUNDS & SOUND NARRATIONS
	
	// Animal Sounds
	static let animalBirds = AudioItem(fileURL: "sound_birds", fileExtension: "wav")
	static let animalBirdsNarration = AudioItem(fileURL: "sound_narration_birds", fileExtension: "wav")
	static let animalCrickets = AudioItem(fileURL: "sound_crickets", fileExtension: "wav")
	static let animalCricketsNarration = AudioItem(fileURL: "sound_narration_crickets", fileExtension: "wav")
	static let animalDuck = AudioItem(fileURL: "sound_duck", fileExtension: "wav")
	static let animalDuckNarration = AudioItem(fileURL: "sound_narration_duck", fileExtension: "wav")
	
	// Craft Sounds
	static let craftsHammering = AudioItem(fileURL: "sound_hammering", fileExtension: "wav")
	static let craftsHammeringNarration = AudioItem(fileURL: "sound_narration_hammering", fileExtension: "wav")
	static let craftsWoodcutting = AudioItem(fileURL: "sound_woodcutting", fileExtension: "wav")
	static let craftsWoodcuttingNarration = AudioItem(fileURL: "sound_narration_woodcutting", fileExtension: "wav")
	static let craftsWriting = AudioItem(fileURL: "sound_writing", fileExtension: "wav")
	static let craftsWritingNarration = AudioItem(fileURL: "sound_narration_writing", fileExtension: "wav")
	
	// Everyday Sounds
	static let everydayClock = AudioItem(fileURL: "sound_clock", fileExtension: "wav")
	static let everydayClockNarration = AudioItem(fileURL: "sound_narration_clock", fileExtension: "wav")
	static let everydayKeychain = AudioItem(fileURL: "sound_keychain", fileExtension: "wav")
	static let everydayKeychainNarration = AudioItem(fileURL: "sound_narration_keychain", fileExtension: "wav")
	static let everydayPaper = AudioItem(fileURL: "sound_paper", fileExtension: "wav")
	static let everydayPaperNarration = AudioItem(fileURL: "sound_narration_paper", fileExtension: "wav")
	
	// Item Sounds
	static let itemsChurchBell = AudioItem(fileURL: "sound_church_bell", fileExtension: "wav")
	static let itemsChurchBellNarration = AudioItem(fileURL: "sound_narration_church_bell", fileExtension: "wav")
	static let itemsDiceRoll = AudioItem(fileURL: "sound_dice_roll", fileExtension: "wav")
	static let itemsDiceRollNarration = AudioItem(fileURL: "sound_narration_dice_roll", fileExtension: "wav")
	static let itemsWindChimes = AudioItem(fileURL: "sound_wind_chimes", fileExtension: "wav")
	static let itemsWindChimesNarration = AudioItem(fileURL: "sound_narration_wind_chimes", fileExtension: "wav")
	
	// Nature Sounds
	static let natureRain = AudioItem(fileURL: "sound_rain", fileExtension: "wav")
	static let natureRainNarration = AudioItem(fileURL: "sound_narration_rain", fileExtension: "wav")
	static let natureStream = AudioItem(fileURL: "sound_stream", fileExtension: "wav")
	static let natureStreamNarration = AudioItem(fileURL: "sound_narration_stream", fileExtension: "wav")
	static let natureWater = AudioItem(fileURL: "sound_water", fileExtension: "wav")
	static let natureWaterNarration = AudioItem(fileURL: "sound_narration_water", fileExtension: "wav")
	
	// Vehicles and Machinery
	static let machineryRunway = AudioItem(fileURL: "sound_runway", fileExtension: "wav")
	static let machineryRunwayNarration = AudioItem(fileURL: "sound_narration_runway", fileExtension: "wav")
	static let machinerySteamTrain = AudioItem(fileURL: "sound_steam_train", fileExtension: "wav")
	static let machinerySteamTrainNarration = AudioItem(fileURL: "sound_narration_steam_train", fileExtension: "wav")
	static let machineryVentilation = AudioItem(fileURL: "sound_ventilation", fileExtension: "wav")
	static let machineryVentilationNarration = AudioItem(fileURL: "sound_narration_ventilation", fileExtension: "wav")
}

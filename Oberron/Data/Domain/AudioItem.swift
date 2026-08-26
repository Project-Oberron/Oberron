//
//  AudioItem.swift
//  Oberron
//
//  Created by Muhammad Akbar Reishandy on 13/08/26.
//

import Foundation

struct AudioItem {
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
	
	// MARK: - Store for our audio
	// Narration
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
	
	// - Questions: Notice
	static let notice1 = AudioItem(fileURL: "notice1", fileExtension: "wav")
	static let notice2 = AudioItem(fileURL: "notice2", fileExtension: "wav")
	static let notice3 = AudioItem(fileURL: "notice3", fileExtension: "wav")
	static let notice4 = AudioItem(fileURL: "notice4", fileExtension: "wav")
	static let notice5 = AudioItem(fileURL: "notice5", fileExtension: "wav")
	
	// - Questions: Perspective
	static let perspective1 = AudioItem(fileURL: "perspective1", fileExtension: "wav")
	static let perspective2 = AudioItem(fileURL: "perspective2", fileExtension: "wav")
	static let perspective3 = AudioItem(fileURL: "perspective3", fileExtension: "wav")
	static let perspective4 = AudioItem(fileURL: "perspective4", fileExtension: "wav")
	static let perspective5 = AudioItem(fileURL: "perspective5", fileExtension: "wav")
	
	// - Questions: Orient
	static let orient1 = AudioItem(fileURL: "orient1", fileExtension: "wav")
	static let orient2 = AudioItem(fileURL: "orient2", fileExtension: "wav")
	static let orient3 = AudioItem(fileURL: "orient3", fileExtension: "wav")
	static let orient4 = AudioItem(fileURL: "orient4", fileExtension: "wav")
	static let orient5 = AudioItem(fileURL: "orient5", fileExtension: "wav")
    
    // Animal Sounds
    static let animalBirds = AudioItem(fileURL: "Birds", fileExtension: "wav")
    static let animalCrickets = AudioItem(fileURL: "Crickets", fileExtension: "wav")
    static let animalDuck = AudioItem(fileURL: "Duck", fileExtension: "wav")
    
    // Craft Sounds
    static let craftsHammering = AudioItem(fileURL: "Hammering", fileExtension: "wav")
    static let craftsWoodcutting = AudioItem(fileURL: "Woodcutting", fileExtension: "wav")
    static let craftsWriting = AudioItem(fileURL: "Writing", fileExtension: "wav")
    
    // Everyday Sounds
    static let everydayClock = AudioItem(fileURL: "Clock", fileExtension: "wav")
    static let everydayKeychain = AudioItem(fileURL: "Keychain", fileExtension: "wav")
    static let everydayPaper = AudioItem(fileURL: "Paper", fileExtension: "wav")
    
    // Item Sounds
    static let itemsChurchBell = AudioItem(fileURL: "Church Bell", fileExtension: "wav")
    static let itemsDiceRoll = AudioItem(fileURL: "Dice Roll", fileExtension: "wav")
    static let itemsWindChimes = AudioItem(fileURL: "Wind Chimes", fileExtension: "wav")
    
    // Nature Sounds
    static let natureRain = AudioItem(fileURL: "Rain", fileExtension: "wav")
    static let natureStream = AudioItem(fileURL: "Stream", fileExtension: "wav")
    static let natureWater = AudioItem(fileURL: "Water", fileExtension: "wav")
    
    // Vehicles and Machinery
    static let machineryRunway = AudioItem(fileURL: "Runway", fileExtension: "wav")
    static let machinerySteamTrain = AudioItem(fileURL: "Steam Train", fileExtension: "wav")
    static let machineryVentilation = AudioItem(fileURL: "Ventilation", fileExtension: "wav")
}

/* Struct Audio Item: String
 
 Enum fileName
 case _sound_ = "file name"
 function - item filename
 return audio item (fileurl.fileName.toString() )

*/

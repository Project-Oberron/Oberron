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
	
	// TODO: Maybe this later?
	// let positionRange:
	// let volumeRange:
	
	var url: URL? {
		guard let url = Bundle.main.url(forResource: self.fileURL, withExtension: self.fileExtension) else {
			print("WARNING > AudioItem: Could not find \(self.fileURL).\(self.fileExtension) in bundle.")
			return nil
		}
		return url
	}
	
	// Store for our audio
    static let narrationSample = AudioItem(fileURL: "narration_sample", fileExtension: "wav")
	static let narrationStart = AudioItem(fileURL: "narration_start", fileExtension: "wav")
    static let narrationRapidSwitch = AudioItem(fileURL: "narration_rapid_switch", fileExtension: "wav")
    static let narrationFinal = AudioItem(fileURL: "narration_final", fileExtension: "wav")
    
	static let sound1Sample = AudioItem(fileURL: "sound1_sample", fileExtension: "wav")
	static let sound2Sample = AudioItem(fileURL: "sound2_sample", fileExtension: "wav")
    
    
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

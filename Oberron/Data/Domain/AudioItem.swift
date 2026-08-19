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
}

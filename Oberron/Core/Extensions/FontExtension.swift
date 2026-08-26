//
//  FontExtension.swift
//  Oberron
//
//  Created by Muhammad Akbar Reishandy on 14/08/26.
//

import SwiftUI

extension Font {
	static var appHuge: Font {
		appFont(size: 60, relativeTo: .largeTitle, isItalic: true)
	}
	
	static var appPrimary: Font {
		appFont(size: 40, relativeTo: .largeTitle, weight: .regular)
	}
	
	static var appButton: Font {
		appFont(size: 30, relativeTo: .title2, weight: .bold)
	}
	
	static var appSecondary: Font {
		appFont(size: 25, relativeTo: .title3, isItalic: true)
	}
	
	static var appFootnote: Font {
		appFont(size: 15, relativeTo: .footnote, weight: .regular)
	}
	
	static var appWidget: Font {
		appFont(size: 12, relativeTo: .caption, weight: .regular)
	}
	
	private static func appFont(
		size: CGFloat,
		relativeTo textStyle: Font.TextStyle,
		weight: Font.Weight = .regular,
		isItalic: Bool = false
	) -> Font {
		let selectedFont = PreferenceService.shared.selectedFont
		
		switch selectedFont {
		case .system:
			var font = Font.system(size: size, weight: weight, design: .default)
			if isItalic { font = font.italic() }
			return font
			
		case .lora, .openDyslexic:
			if let customName = selectedFont.postScriptName(weight: weight, isItalic: isItalic) {
				return .custom(customName, size: size, relativeTo: textStyle)
			}
			return .system(size: size, weight: weight)
		}
	}
}

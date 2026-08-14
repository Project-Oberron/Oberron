//
//  FontExtension.swift
//  Oberron
//
//  Created by Muhammad Akbar Reishandy on 14/08/26.
//

import SwiftUI

extension Font {
	static var loraHuge: Font {
		.custom("Lora-Regular", size: 70, relativeTo: .largeTitle)
	}
	
	static var loraPrimary: Font {
		.custom("Lora-Regular", size: 40, relativeTo: .largeTitle)
	}
	
	static var loraButton: Font {
		.custom("Lora-Regular", size: 30, relativeTo: .title2)
	}
	
	static var loraSecondary: Font {
		.custom("Lora-Italic", size: 25, relativeTo: .title3)
	}
	
	static var loraFootnote: Font {
		.custom("Lora-Regular", size: 15, relativeTo: .footnote)
	}
}

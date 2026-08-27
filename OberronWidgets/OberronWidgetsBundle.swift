//
//  OberronWidgetsBundle.swift
//  OberronWidgets
//
//  Created by Muhammad Akbar Reishandy on 12/08/26.
//

import WidgetKit
import SwiftUI

@main
struct OberronWidgetsBundle: WidgetBundle {
    var body: some Widget {
        OberronWidgets()
		if #available(iOS 18.0, *) {
			OberronWidgetsControl()
		}
    }
}

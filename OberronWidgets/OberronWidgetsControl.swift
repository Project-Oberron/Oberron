//
//  OberronWidgetsControl.swift
//  OberronWidgets
//
//  Created by Muhammad Akbar Reishandy on 12/08/26.
//

import AppIntents
import SwiftUI
import WidgetKit

struct OberronWidgetsControl: ControlWidget {
    static let kind: String = "id.reishandy.Oberron.OberronWidgets"

	var body: some ControlWidgetConfiguration {
		StaticControlConfiguration(
			kind: Self.kind
		) {
			ControlWidgetButton(action: StartSessionIntent()) {
				// TODO: Change following others
				Label("Start Session", systemImage: "play.circle.fill")
			}
		}
		// TODO: Change following others
		.displayName("Start Session")
		.description("Quickly start an Oberron session.")
	}
}

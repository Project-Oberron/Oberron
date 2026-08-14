//
//  NavigationService.swift
//  Oberron
//
//  Created by Muhammad Akbar Reishandy on 11/08/26.
//

import SwiftUI

@MainActor
@Observable
class NavigationService {
	// TODO: Consider custom zstack navigation
	//			^ for the custom animations
	static let shared = NavigationService()
	
	var path = NavigationPath()
	
	func reset() {
		path = NavigationPath()
	}
	
	func startSession() {
		path.append(NavRoute.att)
	}
}

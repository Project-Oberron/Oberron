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
	static let shared = NavigationService()
	
	var path = NavigationPath()
	
	func reset() {
		path = NavigationPath()
	}
	
	func startSession() {
		path.append(NavRoute.att)
	}
}

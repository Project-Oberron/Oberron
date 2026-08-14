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
	
	var currentRoute: NavRoute = .home
	
	func navigate(to route: NavRoute) {
		currentRoute = route
	}
	
	func startSession() {
		currentRoute = .att
	}
}

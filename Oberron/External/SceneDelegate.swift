//
//  SceneDelegate.swift
//  Oberron
//
//  Created by Muhammad Akbar Reishandy on 12/08/26.
//

import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		if let shortcutItem = connectionOptions.shortcutItem {
			handleShortcut(shortcutItem)
		}
	}
	
	func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
		handleShortcut(shortcutItem)
		completionHandler(true)
	}
	
	@MainActor
	private func handleShortcut(_ item: UIApplicationShortcutItem) {
		if item.type == "StartSessionAction" {
			NavigationService.shared.startSession()
		}
	}
}

//
//  AppDelegate.swift
//  Oberron
//
//  Created by Muhammad Akbar Reishandy on 12/08/26.
//

import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
	func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
		
		let config = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
		config.delegateClass = SceneDelegate.self
		return config
	}
}

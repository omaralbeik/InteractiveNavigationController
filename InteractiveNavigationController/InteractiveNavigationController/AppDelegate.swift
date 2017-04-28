//
//  AppDelegate.swift
//  InteractiveNavigationController
//
//  Created by Omar Albeik on 4/28/17.
//  Copyright © 2017 Omar Albeik. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
	
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		
		window = UIWindow(frame: UIScreen.main.bounds)
		window?.makeKeyAndVisible()
		
		let navController = FeedNavigationController(rootViewController: FeedViewController())
		window?.rootViewController = navController
		
		return true
	}
	
}


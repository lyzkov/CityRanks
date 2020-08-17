//
//  AppDelegate.swift
//  CityRanks
//
//  Created by lyzkov on 05/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import UIKit

final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        
        installRootViewController()
        
        return true
    }
    
    func installRootViewController() {
        let rootNavigation = UINavigationController()
        CitiesWireframe().presentModule(from: rootNavigation)
        
        window?.rootViewController = rootNavigation
        window?.makeKeyAndVisible()
    }

}

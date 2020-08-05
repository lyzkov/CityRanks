//
//  FakeAppDelegate.swift
//  CityRanks
//
//  Created by lyzkov on 05/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import UIKit

final class FakeAppDelegate: NSObject, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil)
        -> Bool {
        window = UIWindow()
        window?.rootViewController = UINavigationController(rootViewController: UIViewController())
        window?.makeKeyAndVisible()

        return true
    }

}

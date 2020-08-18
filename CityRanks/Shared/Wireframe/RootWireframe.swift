//
//  RootWireframe.swift
//  CityRanks
//
//  Created by lyzkov on 06/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import UIKit

protocol RootWireframe {
    func showRootViewController(_ viewController: UIViewController, inWindow: UIWindow)
}

extension RootWireframe {

    func showRootViewController(_ viewController: UIViewController, inWindow: UIWindow) {
        let navigationController = getNavigationController()
        navigationController.viewControllers = [viewController]
        inWindow.rootViewController = navigationController
        inWindow.makeKeyAndVisible()
    }
    
    private func getNavigationController() -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.navigationBar.isHidden = true
        return navigationController
    }

}

//
//  WireframeProtocol.swift
//  CityRanks
//
//  Created by lyzkov on 17/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import Foundation
import UIKit

protocol WireframeProtocol: class {
    var root: UIViewController? { get set }
    var view: UIViewController { get }
}

extension WireframeProtocol {
    
    func presentModule(from window: UIWindow) {
        window.rootViewController = view
        window.makeKeyAndVisible()
        root = view
    }
    
    func presentModule(from navigationController: UINavigationController) {
        navigationController.pushViewController(view, animated: true)
        root = navigationController
    }
    
    func presentModule(from viewController: UIViewController) {
        viewController.present(view, animated: true)
        root = viewController
    }
    
    func presentAlert(from error: Error) {
        let alert = UIAlertController(
            title: "Unexpected Error",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        alert.addAction(.init(title: "OK", style: .default))
        root?.present(alert, animated: true)
    }
    
}

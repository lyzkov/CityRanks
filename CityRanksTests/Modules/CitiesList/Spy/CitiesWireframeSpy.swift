//
//  CitiesWireframeSpy.swift
//  CityRanksTests
//
//  Created by lyzkov on 07/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import UIKit
@testable import CityRanks

final class CitiesWireframeSpy: CitiesWireframeProtocol {
    
    var view: UIViewController = UIViewController()
    
    var root: UIViewController?
    
    var didPresentFromWindow = false
    
    func presentModule(from window: UIWindow) {
        didPresentFromWindow = true
    }
    
    var didPresentFromNavigationController = false
    
    func presentModule(from navigationController: UINavigationController) {
        didPresentFromNavigationController = true
    }
    
    var didPresentFromViewController = false
    
    func presentModule(from viewController: UIViewController) {
        didPresentFromViewController = true
    }
    
    var didPresentAlert = false
    var error: Error?

    func presentAlert(from error: Error) {
        didPresentAlert = true
        self.error = error
    }
    
    var didPresentDetailsForCity: City? = nil
    
    func presentDetails(for city: City) {
        didPresentDetailsForCity = city
    }
}

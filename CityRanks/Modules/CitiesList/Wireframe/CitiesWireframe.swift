//
//  CitiesWireframe.swift
//  CityRanks
//
//  Created by lyzkov on 06/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import UIKit

protocol WireframeProtocol {
    
    var root: UIViewController? { get set }
    func presentModule(from window: UIWindow)
    func presentModule(from navigationController: UINavigationController)
    func presentModule(from viewController: UIViewController)
    func presentAlert(from error: Error)
}

final class CitiesWireframe: WireframeProtocol {
    
    var root: UIViewController?
    
    var view: CitiesView {
        let view = CitiesView()
        let interactor = CitiesInteractor()
        let presenter = CitiesPresenter(wireframe: self, view: view, interactor: interactor)
        interactor.presenter = presenter
        view.presenter = presenter
        
        return view
    }
    
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
        root?.present(alert, animated: true)
    }

}

extension CitiesWireframe: RootWireframe {
    
}

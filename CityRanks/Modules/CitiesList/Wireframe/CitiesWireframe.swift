//
//  CitiesWireframe.swift
//  CityRanks
//
//  Created by lyzkov on 06/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

protocol CitiesWireframeProtocol {
    func presentDetails(for city: City)
    
    func presentModule(from navigationController: UINavigationController)
    func presentModule(from viewController: UIViewController)
    func presentAlert(from error: Error)
}

final class CitiesWireframe: CitiesWireframeProtocol, WireframeProtocol {
    
    weak var root: UIViewController?
    
    var view: UIViewController {
        let view = CityItemListHostingView()
        let interactor = CitiesInteractor()
        let presenter = CitiesPresenter(wireframe: self, view: view, interactor: interactor)
        interactor.presenter = presenter
        view.presenter = presenter
        
        return view
    }
    
    func presentDetails(for city: City) {
        guard let navigationController = root as? UINavigationController else { return }
        CityDetailsWireframe(city: city).presentModule(from: navigationController)
    }

}

fileprivate class CityItemListHostingView: UIHostingController<CityItemList> {
    
    var presenter: CitiesPresenterInputProtocol!
    
    convenience init() {
        self.init(rootView: CityItemList())
    }
    
}

extension CityItemListHostingView: CitiesViewProtocol {
    
    func renderCitiesList() {
    }
    
    func renderCityImage(forRowAt indexPath: IndexPath) {
    }
    
}

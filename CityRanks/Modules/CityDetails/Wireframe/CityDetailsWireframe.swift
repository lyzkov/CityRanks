//
//  CityDetailsWireframe.swift
//  CityRanks
//
//  Created by lyzkov on 17/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import Foundation
import UIKit

protocol CityDetailsWireframeProtocol: WireframeProtocol {
}

final class CityDetailsWireframe: CityDetailsWireframeProtocol {
    
    weak var root: UIViewController?
    
    var view: UIViewController {
        let view = CityDetailsView()
        let interactor = CityDetailsInteractor()
        let presenter = CityDetailsPresenter(wireframe: self, view: view, interactor: interactor, city: city)
        interactor.presenter = presenter
        view.presenter = presenter
        
        return view
    }
    
    let city: City
    
    init(city: City) {
        self.city = city
    }
    
}

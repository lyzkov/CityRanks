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
        let cityDetailsView = CityDetailsView()
        let interactor = CityDetailsInteractor()
        let presenter = CityDetailsPresenter(wireframe: self, view: cityDetailsView, interactor: interactor, city: city)
        interactor.presenter = presenter
        cityDetailsView.presenter = presenter
        
        return cityDetailsView
    }
    
    let city: City
    
    init(city: City) {
        self.city = city
    }
    
}

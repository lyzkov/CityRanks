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
        let presenter = CityDetailsPresenter(wireframe: self, view: view, city: city)
        view.presenter = presenter
        
        return view
    }
    
    let city: City
    
    init(city: City) {
        self.city = city
    }
    
}

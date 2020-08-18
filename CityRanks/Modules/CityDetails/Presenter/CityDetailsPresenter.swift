//
//  CityDetailsPresenter.swift
//  CityRanks
//
//  Created by lyzkov on 17/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import Foundation

protocol CityDetailsPresenterInputProtocol: class {
    func loadCityDetails()
}

protocol CityDetailsPresenterOutputProtocol {
    
}

final class CityDetailsPresenter: CityDetailsPresenterOutputProtocol {
    
    private let wireframe: CityDetailsWireframeProtocol
    private weak var view: CityDetailsViewProtocol!
    
    private var city: City
    
    init(wireframe: CityDetailsWireframeProtocol, view: CityDetailsViewProtocol, city: City) {
        self.wireframe = wireframe
        self.view = view
        self.city = city
    }
    
}

extension CityDetailsPresenter: CityDetailsPresenterInputProtocol {
    
    func loadCityDetails() {
        view.render(city: city)
    }
    
}

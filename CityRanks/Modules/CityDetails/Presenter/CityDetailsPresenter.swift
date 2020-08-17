//
//  CityDetailsPresenter.swift
//  CityRanks
//
//  Created by lyzkov on 17/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import Foundation

protocol CityDetailsPresenterInputProtocol: class {
    
}

protocol CityDetailsPresenterOutputProtocol {
    
}

final class CityDetailsPresenter: CityDetailsPresenterInputProtocol, CityDetailsPresenterOutputProtocol {
    
    private let wireframe: CityDetailsWireframeProtocol
    private weak var view: CityDetailsViewProtocol!
    
    init(wireframe: CityDetailsWireframeProtocol, view: CityDetailsViewProtocol) {
        self.wireframe = wireframe
        self.view = view
    }
    
}

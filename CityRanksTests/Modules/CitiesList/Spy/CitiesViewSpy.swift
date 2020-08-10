//
//  CitiesViewSpy.swift
//  CityRanksTests
//
//  Created by lyzkov on 07/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import Foundation
@testable import CityRanks

final class CitiesViewSpy: CitiesViewProtocol {

    var presenter: CitiesPresenterInputProtocol?
    
    var didRenderCities: [City]?
    
    
    func render(cities: [City]) {
        didRenderCities = cities
    }

}

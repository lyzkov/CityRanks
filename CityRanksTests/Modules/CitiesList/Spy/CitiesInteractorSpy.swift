//
//  CitiesInteractorSpy.swift
//  CityRanksTests
//
//  Created by lyzkov on 07/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import Foundation
@testable import CityRanks

final class CitiesInteractorSpy: CitiesInteractorProtocol {
    
    var presenter: CitiesPresenterOutputProtocol?
    
    var didFetchCities = false
    var citiesToPresent: [City] = []
    
    func fetchCities(refresh: Bool = false) {
        didFetchCities = true
        presenter?.present(cities: citiesToPresent)
    }
    
    func fetchCities() {
        self.fetchCities(refresh: false)
    }
    
    var didFetchImage = false
    
    func fetchImage(for city: City) {
        didFetchImage = true
    }
    
    var didUpdateCity: City? = nil
    
    func update(city: City) {
        didUpdateCity = city
    }

}

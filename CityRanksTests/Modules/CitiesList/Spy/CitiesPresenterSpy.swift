//
//  CitiesPresenterSpy.swift
//  CityRanksTests
//
//  Created by lyzkov on 10/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import Foundation
@testable import CityRanks

final class CitiesPresenterSpy: CitiesPresenterInputProtocol, CitiesPresenterOutputProtocol {
    
    var didLoad = false
    
    func load() {
        didLoad = true
    }
    
    var citiesToPresent: [City] = []
    
    func present(cities: [City]) {
        citiesToPresent = cities
    }
    
    var errorToShow: Error?
    
    func showAlert(from error: Error) {
        errorToShow = error
    }
    
}

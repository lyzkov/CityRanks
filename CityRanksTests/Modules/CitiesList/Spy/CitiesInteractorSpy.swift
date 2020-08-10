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
    
    var didFetch = false
    
    func fetchCities() {
        didFetch = true
    }

}

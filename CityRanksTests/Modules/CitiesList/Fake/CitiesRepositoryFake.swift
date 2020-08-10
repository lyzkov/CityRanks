//
//  CitiesRepositoryFake.swift
//  CityRanksTests
//
//  Created by lyzkov on 10/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import Foundation
@testable import CityRanks

final class CitiesRepositoryFake: CitiesRepositoryProtocol {
    
    var citiesToHandle: [City] = []
    
    func fetchCities(completion handler: (Result<[City], Error>) -> Void) {
        handler(.success(citiesToHandle))
    }
    
}

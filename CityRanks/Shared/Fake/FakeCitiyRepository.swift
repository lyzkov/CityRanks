//
//  FakeCityRepository.swift
//  CityRanks
//
//  Created by lyzkov on 10/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import Foundation
import CityRanksAPIClient

final class FakeCityRepository: CityRepositoryProtocol {
    
    var cities: [City] = []
    
    var error: Error? = nil
    
    let fixtures = FixturesLoader<[CityRanksAPIClient.City]>()
    
    init() {
        cities = (try? fixtures.load(resource: "CitiesList").compactMap(City.init(from:))) ?? []
    }
    
    func fetchCities(completion handler: (Result<[City], Error>) -> Void) {
        if let error = error {
            handler(.failure(error))
        } else {
            handler(.success(cities))
        }
    }
    
}

extension Array where Element == City {
    
    static let polish: [City] = {
        return FakeCityRepository().cities
    }()
    
}

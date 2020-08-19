//
//  FakeCityRepository.swift
//  CityRanks
//
//  Created by lyzkov on 10/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import Foundation

final class FakeCityRepository: CityRepositoryProtocol {
    
    var cities: [City]
    
    var error: Error? = nil
    
    let fixtures = FixturesLoader<[CityFixture]>()
    
    init() {
        cities = (try? fixtures.load(resource: "Cities").compactMap(City.init(from:))) ?? []
    }
    
    func fetchCities(completion handler: (Result<[City], Error>) -> Void) {
        if let error = error {
            handler(.failure(error))
        } else {
            handler(.success(cities))
        }
    }
    
    func fetchDetails(for city: City, completion handler: @escaping (Result<City, Error>) -> Void) {
        if let error = error {
            handler(.failure(error))
        } else if let index = cities.firstIndex(of: city) {
            handler(.success(cities[index]))
        }
    }
    
}

extension Array where Element == City {
    
    static let polish: [City] = {
        return FakeCityRepository().cities
    }()
    
}

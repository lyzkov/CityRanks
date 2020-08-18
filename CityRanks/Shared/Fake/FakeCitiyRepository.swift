//
//  FakeCityRepository.swift
//  CityRanks
//
//  Created by lyzkov on 10/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import Foundation
import CityRanksAPIClient

/// TODO: Replace with actual implementation that fetches cities from API
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
    
    func fetchDetails(for city: City, completion handler: @escaping (Result<City, Error>) -> Void) {
        if let error = error {
            handler(.failure(error))
        } else {
            handler(.success(City(id: 1, name: "Wrocław", favorite: true, imageData: .placeholder(url: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/07/Herb_wroclaw.svg/404px-Herb_wroclaw.svg.png")!), visitors: [User(name: "ddd")])))
        }
    }
    
}

extension Array where Element == City {
    
    static let polish: [City] = {
        return FakeCityRepository().cities
    }()
    
}

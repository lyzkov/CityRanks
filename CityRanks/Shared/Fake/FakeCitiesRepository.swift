//
//  FakeCitiesRepository.swift
//  CityRanks
//
//  Created by lyzkov on 10/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import Foundation

protocol CitiesRepositoryProtocol {
    func fetchCities(completion handler: (Result<[City], Error>) -> Void)
}

/// TODO: Replace with actual implementation that fetches cities from API
final class FakeCitiesRepository: CitiesRepositoryProtocol {
    
    var cities: [City] = .polish
    
    var error: Error? = nil
    
    func fetchCities(completion handler: (Result<[City], Error>) -> Void) {
        if let error = error {
            handler(.failure(error))
        } else {
            handler(.success(cities))
        }
    }
    
}

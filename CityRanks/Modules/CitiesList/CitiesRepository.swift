//
//  CitiesRepository.swift
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
final class CitiesRepository: CitiesRepositoryProtocol {
    
    func fetchCities(completion handler: (Result<[City], Error>) -> Void) {
        handler(.success(.polish))
    }
    
}

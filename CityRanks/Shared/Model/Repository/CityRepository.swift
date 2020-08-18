//
//  CityRepository.swift
//  CityRanks
//
//  Created by lyzkov on 16/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import Foundation
import CityRanksAPIClient

protocol CityRepositoryProtocol {
    func fetchCities(completion handler: @escaping (Result<[City], Error>) -> Void)
    func fetchDetails(for city: City, completion handler: @escaping (Result<City, Error>) -> Void)
}

final class CityRepository: CityRepositoryProtocol {
    
    func fetchCities(completion handler: @escaping (Result<[City], Error>) -> Void) {
        CityAPI.listCities { cities, error in
            if let error = error {
                handler(.failure(error))
            }
            if let cities = cities {
                handler(.success(cities.compactMap(City.init(from:))))
            }
        }
    }
    
    func fetchDetails(for city: City, completion handler: @escaping (Result<City, Error>) -> Void) {
        
    }
    
}

extension City {
    
    init?(from city: CityRanksAPIClient.City) {
        guard let imageUrl = URL(string: city.image ?? "") else {
            return nil
        }
        self.init(id: Int(city.id), name: city.name, imageUrl: imageUrl)
    }
    
}

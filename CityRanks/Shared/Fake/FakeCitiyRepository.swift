//
//  FakeCityRepository.swift
//  CityRanks
//
//  Created by lyzkov on 10/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import Foundation

/// TODO: Replace with actual implementation that fetches cities from API
final class FakeCityRepository: CityRepositoryProtocol {
    
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

extension City {
    
    static let warsaw = City(id: 1, name: "Warszawa", imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b5/POL_Warszawa_COA.svg/286px-POL_Warszawa_COA.svg.png")
    
    static let wroclaw = City(id: 2, name: "Wrocław", imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/07/Herb_wroclaw.svg/404px-Herb_wroclaw.svg.png")
    
    static let cracow = City(id: 3, name: "Kraków", imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/4/41/POL_Krak%C3%B3w_COA.svg/1200px-POL_Krak%C3%B3w_COA.svg.png")
    
}

extension Array where Element == City {
    
    static let polish = [
        City.wroclaw,
        City.warsaw,
        City.cracow,
    ]
    
}

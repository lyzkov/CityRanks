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
        let id = Int64(city.id)
        
        var resultCity: City = city
        
        let taskGroup = DispatchGroup()
        taskGroup.enter()
        CityAPI.getCityDetails(id: id) { city, error in
            defer { taskGroup.leave() }
            if let error = error {
                handler(.failure(error))
            }
            if let city = city {
                resultCity.update(from: city)
            }
        }
        taskGroup.enter()
        CityAPI.getCityVisitors(id: id) { visitors, error in
            defer { taskGroup.leave() }
            if let error = error {
                handler(.failure(error))
            }
            if let visitors = visitors {
                resultCity.visitors = visitors.map(User.init(from:))
            }
        }
        taskGroup.notify(queue: .main) {
            handler(.success(resultCity))
        }
    }
    
}

fileprivate extension City {
    
    init?(from city: CityRanksAPIClient.City) {
        guard let imageUrl = URL(string: city.image ?? "") else {
            return nil
        }
        self.init(id: Int(city.id), name: city.name, imageUrl: imageUrl)
    }
    
    mutating func update(from city: CityRanksAPIClient.City) {
        name = city.name != name ? city.name : name
        if case .placeholder(let url) = imageData,
            let newUrl = city.image.flatMap(URL.init(string:)),
            url != newUrl {
            imageData = .placeholder(url: newUrl)
        }
        rating = city.rating != rating ? city.rating : rating
    }
    
}

fileprivate extension User {
    
    init(from visitor: CityRanksAPIClient.Visitor) {
        self.init(name: visitor.name)
    }
    
}

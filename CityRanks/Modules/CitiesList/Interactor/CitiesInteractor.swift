//
//  CitiesInteractor.swift
//  CityRanks
//
//  Created by lyzkov on 06/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import Foundation

protocol CitiesInteractorProtocol {
    var presenter: CitiesPresenterOutputProtocol? { get set }
    func fetchCities()
    func fetchCityImage(for city: City)
}

final class CitiesInteractor: CitiesInteractorProtocol {
    
    weak var presenter: CitiesPresenterOutputProtocol?
    
    private let dataManager: CitiesRepositoryProtocol
    private let imageFetcher: ImageFetcherProtocol
    
    private var cities: Set<City> = .init()
    
    init(dataManager: CitiesRepositoryProtocol = FakeCitiesRepository(), imageFetcher: ImageFetcherProtocol = FakeImageFetcher()) {
        self.dataManager = dataManager
        self.imageFetcher = imageFetcher
    }
    
    func fetchCities() {
        dataManager.fetchCities { result in
            switch result {
            case .success(let cities):
                self.cities = Set(cities)
                presenter?.present(cities: Array(self.cities))
            case .failure(let error):
                self.cities = .init()
                presenter?.showAlert(from: error)
            }
        }
    }
    
    func fetchCityImage(for city: City) {
        var city = city
        guard case let .placeholder(url) = city.imageData else {
            return
        }
        imageFetcher.fetch(from: url) { [weak self] (image: FetchableImage) in
            city.imageData = image
            self?.cities.update(with: city)
            self?.presenter?.presentImage(city: city)
        }
    }
    
}

extension Set where Element == City {
    
    func sortedByName() -> [City] {
        return sorted { lhs, rhs in
            lhs.name < rhs.name
        }
    }
    
}

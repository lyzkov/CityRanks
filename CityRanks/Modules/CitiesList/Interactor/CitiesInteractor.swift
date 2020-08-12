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
    func fetchCities(refresh: Bool)
    func fetchImage(for city: City)
    func update(city: City)
}

protocol CityStorage: Storage where Entity == City {
    init?()
}

extension UserDefaultsStorage: CityStorage where Entity == City {
    
    convenience init?() {
        self.init(name: "Cities")
    }
    
}

final class FakeCityStorage: CityStorage {
    
    func store(_ entity: City) throws {
    }
    
    func restore(_ entity: inout City) throws {
    }
    
}

final class CitiesInteractor<Storage: CityStorage>: CitiesInteractorProtocol {
    
    weak var presenter: CitiesPresenterOutputProtocol?
    
    private let dataManager: CitiesRepositoryProtocol
    private let imageFetcher: ImageFetcherProtocol
    private let storage: Storage?
    
    private var cities: Set<City> = .init()
    
    init(dataManager: CitiesRepositoryProtocol = FakeCitiesRepository(), imageFetcher: ImageFetcherProtocol = FakeImageFetcher(), storage: Storage? = Storage()) {
        self.dataManager = dataManager
        self.imageFetcher = imageFetcher
        self.storage = storage
    }
    
    func fetchCities() {
        fetchCities(refresh: false)
    }
    
    func fetchCities(refresh: Bool) {
        guard cities.isEmpty || refresh else {
            presenter?.present(cities: cities.sorted())
            
            return
        }
        
        dataManager.fetchCities { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(var cities):
                do {
                    for index in cities.indices {
                        try storage?.restore(&cities[index])
                    }
                    self.cities = Set(cities)
                } catch {
                    self.presenter?.showAlert(from: error)
                }
                self.presenter?.present(cities: self.cities.sorted())
            case .failure(let error):
                self.cities = []
                presenter?.showAlert(from: error)
            }
        }
    }
    
    func fetchImage(for city: City) {
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
    
    func update(city: City) {
        cities.update(with: city)
        do {
            try storage?.store(city)
        } catch {
            presenter?.showAlert(from: error)
        }
        presenter?.present(cities: cities.sorted())
    }
    
}

extension CitiesInteractor where Storage == FakeCityStorage {
    
    convenience init(dataManager: CitiesRepositoryProtocol = FakeCitiesRepository(), imageFetcher: ImageFetcherProtocol = FakeImageFetcher()) {
        self.init(dataManager: dataManager, imageFetcher: imageFetcher, storage: FakeCityStorage())
    }
    
}

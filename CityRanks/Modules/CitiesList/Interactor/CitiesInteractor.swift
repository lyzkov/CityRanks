//
//  CitiesInteractor.swift
//  CityRanks
//
//  Created by lyzkov on 06/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import Foundation
import Storage
import ImageFetcher

protocol CitiesInteractorProtocol {
    var presenter: CitiesPresenterOutputProtocol? { get set }
    func fetchCities()
    func fetchCities(refresh: Bool)
    func fetchImage(for city: City)
    func update(city: City)
}

final class CitiesInteractor: CitiesInteractorProtocol {
    
    weak var presenter: CitiesPresenterOutputProtocol?
    private let dataManager: CitiesRepositoryProtocol
    private let imageFetcher: ImageFetcherProtocol
    private let storage: CityStorage
    
    private var cities: OrderedSet<City> = []
    
    init(dataManager: CitiesRepositoryProtocol = ServiceLocator.cityRepository, imageFetcher: ImageFetcherProtocol = ServiceLocator.imageFetcher, storage: CityStorage = ServiceLocator.cityStorage) {
        self.dataManager = dataManager
        self.imageFetcher = imageFetcher
        self.storage = storage
    }
    
    func fetchCities() {
        fetchCities(refresh: false)
    }
    
    func fetchCities(refresh: Bool) {
        guard cities.isEmpty || refresh else {
            presenter?.present(cities: Array(cities))
            
            return
        }
        
        dataManager.fetchCities { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(var cities):
                do {
                    for index in cities.indices {
                        try storage.restore(&cities[index])
                    }
                    self.cities = OrderedSet(sequence: cities)
                } catch {
                    self.presenter?.showAlert(from: error)
                }
                self.presenter?.present(cities: Array(self.cities))
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
        imageFetcher.fetch(from: url) { [weak self] (image: ImageResource) in
            city.imageData = image
            self?.cities.update(with: city)
            self?.presenter?.presentImage(city: city)
        }
    }
    
    func update(city: City) {
        cities.update(with: city)
        do {
            try storage.store(city)
        } catch {
            presenter?.showAlert(from: error)
        }
        presenter?.present(cities: Array(cities))
    }
    
}

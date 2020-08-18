//
//  CityDetailsInteractor.swift
//  CityRanks
//
//  Created by lyzkov on 17/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import Foundation
import ImageFetcher

protocol CityDetailsInteractorProtocol {
    var presenter: CityDetailsPresenterOutputProtocol? { get set }
    
    func fetchDetails(for city: City, refresh: Bool)
    func fetchDetails(for city: City)
    func fetchImage(for city: City)
}

final class CityDetailsInteractor: CityDetailsInteractorProtocol {
    
    weak var presenter: CityDetailsPresenterOutputProtocol?
    private let repository: CityRepositoryProtocol
    private let imageFetcher: ImageFetcherProtocol
    
    private var city: City?
    
    init(repository: CityRepositoryProtocol = ServiceLocator.cityRepository, imageFetcher: ImageFetcherProtocol = ServiceLocator.imageFetcher) {
        self.repository = repository
        self.imageFetcher = imageFetcher
    }
    
    func fetchDetails(for city: City) {
        fetchDetails(for: city, refresh: false)
    }
    
    func fetchDetails(for city: City, refresh: Bool) {
        if let city = self.city, !refresh {
            presenter?.present(cityDetails: city)
            
            return
        }
        
        repository.fetchDetails(for: city) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let city):
                self.city = city
                self.presenter?.present(cityDetails: city)
            case .failure(let error):
                self.city = nil
                self.presenter?.showAlert(from: error)
            }
        }
    }
    
    func fetchImage(for city: City) {
        guard case let .placeholder(url) = city.imageData else {
            return
        }
        imageFetcher.fetch(from: url) { [weak self] (image: ImageResource) in
            guard let city = self?.city else { return }
            self?.city?.imageData = image
            self?.presenter?.present(cityDetails: city)
        }
    }
    
}

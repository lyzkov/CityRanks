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
    func fetchCityImage(from url: URL, forRowAt indexPath: IndexPath)
}

final class CitiesInteractor: CitiesInteractorProtocol {
    
    weak var presenter: CitiesPresenterOutputProtocol?
    
    private let dataManager: CitiesRepositoryProtocol
    
    init(dataManager: CitiesRepositoryProtocol = CitiesRepository()) {
        self.dataManager = dataManager
    }
    
    func fetchCities() {
        dataManager.fetchCities { result in
            switch result {
            case .success(let cities):
                presenter?.present(cities: cities)
            case .failure(let error):
                presenter?.showAlert(from: error)
            }
        }
    }
    
    func fetchCityImage(from url: URL, forRowAt indexPath: IndexPath) {
        DispatchQueue.global().async { [weak self] in
            guard let data = try? Data(contentsOf: url) else {
                return
            }
            DispatchQueue.main.async {
                self?.presenter?.present(cityImage: data, forRowAt: indexPath)
            }
        }
    }
    
}

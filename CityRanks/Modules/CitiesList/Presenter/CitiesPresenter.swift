//
//  CitiesPresenter.swift
//  CityRanks
//
//  Created by lyzkov on 06/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import Foundation

protocol CitiesPresenterInputProtocol {
    func loadCities()
    func loadCityImage(from url: URL, forRowAt indexPath: IndexPath)
}

protocol CitiesPresenterOutputProtocol: class {
    func present(cities: [City])
    func present(cityImage: Data, forRowAt indexPath: IndexPath)
    func showAlert(from error: Error)
}

final class CitiesPresenter {
    
    private let view: CitiesViewProtocol
    
    private let interactor: CitiesInteractorProtocol
    
    private let wireframe: WireframeProtocol
    
    private let cities: [CityRenderable] = []
    
    init(wireframe: WireframeProtocol, view: CitiesViewProtocol, interactor: CitiesInteractorProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
    
}

extension CitiesPresenter: CitiesPresenterInputProtocol {
    
    func loadCities() {
        interactor.fetchCities()
    }
    
    func loadCityImage(from url: URL, forRowAt indexPath: IndexPath) {
        interactor.fetchCityImage(from: url, forRowAt: indexPath)
        view.render(cityImage: .loading, forRowAt: indexPath)
    }
    
}

extension CitiesPresenter: CitiesPresenterOutputProtocol {
    
    func present(cities: [City]) {
        view.render(cities: cities.map(CityRenderable.init))
    }
    
    func present(cityImage: Data, forRowAt indexPath: IndexPath) {
        if let image = CityImage(from: cityImage) {
            view.render(cityImage: image, forRowAt: indexPath)
        }
    }
    
    func showAlert(from error: Error) {
        wireframe.presentAlert(from: error)
    }
    
}

//
//  CitiesPresenter.swift
//  CityRanks
//
//  Created by lyzkov on 06/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import Foundation

protocol CitiesViewDataSource {
    func city(for indexPath: IndexPath) -> CityRenderable
    var numberOfRows: Int { get }
}

protocol CitiesPresenterInputProtocol: CitiesViewDataSource {
    func loadCities()
    func loadCityImage(forRowAt indexPath: IndexPath)
}

protocol CitiesPresenterOutputProtocol: class {
    func present(cities: [City])
    func presentImage(city: City)
    func showAlert(from error: Error)
}

final class CitiesPresenter {
    
    private let view: CitiesViewProtocol
    
    private let interactor: CitiesInteractorProtocol
    
    private let wireframe: WireframeProtocol
    
    private var cities: [City] = []
    
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
    
    func loadCityImage(forRowAt indexPath: IndexPath) {
        let city = cities[indexPath.item]
        interactor.fetchCityImage(for: city)
        view.renderCityImage(forRowAt: indexPath)
    }
    
    func city(for indexPath: IndexPath) -> CityRenderable {
        return cities[indexPath.item]
    }
    
    var numberOfRows: Int {
        return cities.count
    }
    
}

extension CitiesPresenter: CitiesPresenterOutputProtocol {
    
    func present(cities: [City]) {
        self.cities = cities
        view.renderCitiesList()
    }
    
    func presentImage(city: City) {
        if let index = cities.firstIndex(of: city) {
            cities[index] = city
            view.renderCityImage(forRowAt: IndexPath(item: index, section: 0))
        }
    }
    
    func showAlert(from error: Error) {
        wireframe.presentAlert(from: error)
    }
    
}

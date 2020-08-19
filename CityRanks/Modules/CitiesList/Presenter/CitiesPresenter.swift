//
//  CitiesPresenter.swift
//  CityRanks
//
//  Created by lyzkov on 06/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import Foundation

protocol CitiesViewDataSource {
    var numberOfRows: Int { get }
    func city(for indexPath: IndexPath) -> CityRenderable
}

protocol CitiesPresenterInputProtocol: CitiesViewDataSource {
    func loadCities()
    func loadCityImage(forRowAt indexPath: IndexPath)
    func filterCities(favorites: Bool)
    func toggleFavorite(forRowAt indexPath: IndexPath)
    func showDetails(forRowAt indexPath: IndexPath)
}

protocol CitiesPresenterOutputProtocol: class {
    func present(cities: [City])
    func presentImage(city: City)
    func showAlert(from error: Error)
}

final class CitiesPresenter {
    
    private let view: CitiesViewProtocol
    
    private let interactor: CitiesInteractorProtocol
    
    private let wireframe: CitiesWireframeProtocol
    
    private var cities: [City] = []
    
    private var favoritesOnly: Bool = false
    
    init(wireframe: CitiesWireframeProtocol, view: CitiesViewProtocol, interactor: CitiesInteractorProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
    
}

extension CitiesPresenter: CitiesViewDataSource {
    
    func city(for indexPath: IndexPath) -> CityRenderable {
        return cities[indexPath.item]
    }
    
    var numberOfRows: Int {
        return cities.count
    }
    
}

extension CitiesPresenter: CitiesPresenterInputProtocol {
    
    func loadCities() {
        interactor.fetchCities()
    }
    
    func loadCityImage(forRowAt indexPath: IndexPath) {
        let city = cities[indexPath.item]
        interactor.fetchImage(for: city)
        view.renderCityImage(forRowAt: indexPath)
    }
    
    func filterCities(favorites: Bool) {
        favoritesOnly = favorites
        interactor.fetchCities()
    }
    
    func toggleFavorite(forRowAt indexPath: IndexPath) {
        var city = cities[indexPath.item]
        city.favorite = city.favorite ? false : true
        interactor.update(city: city)
    }
    
    func showDetails(forRowAt indexPath: IndexPath) {
        let city = cities[indexPath.item]
        wireframe.presentDetails(for: city)
    }
    
}

extension CitiesPresenter: CitiesPresenterOutputProtocol {
    
    func present(cities: [City]) {
        self.cities = cities
            .filter { city in
                favoritesOnly ? city.favorite : true
            }
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
//        view.renderCitiesList()
    }
    
}

//
//  CitiesPresenterSpy.swift
//  CityRanksTests
//
//  Created by lyzkov on 10/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import Foundation
@testable import CityRanks

final class CitiesPresenterSpy: CitiesPresenterInputProtocol, CitiesPresenterOutputProtocol {
    
    var didLoadCities = false
    
    func loadCities() {
        didLoadCities = true
    }
    
    var didLoadCityImage = false
    var didLoadCityImageIndexPath: IndexPath? = nil
    
    func loadCityImage(forRowAt indexPath: IndexPath) {
        didLoadCityImage = true
        didLoadCityImageIndexPath = indexPath
    }
    
    var didFilterCities = false
    var didFIlterCitiesFavorites: Bool? = nil
    
    func filterCities(favorites: Bool) {
        didFilterCities = true
        didFIlterCitiesFavorites = favorites
    }
    
    func toggleFavorite(forRowAt indexPath: IndexPath) {
        
    }
    
    func presentImage(city: City) {
        
    }
    
    func city(for indexPath: IndexPath) -> CityRenderable {
        return citiesToPresent[indexPath.row]
    }
    
    var numberOfRows: Int {
        return citiesToPresent.count
    }
    
    var citiesToPresent: [City] = []
    
    func present(cities: [City]) {
        citiesToPresent = cities
    }
    
    var errorToShow: Error?
    
    func showAlert(from error: Error) {
        errorToShow = error
    }
    
}

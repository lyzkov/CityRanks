//
//  CitiesInteractorTests.swift
//  CityRanksTests
//
//  Created by lyzkov on 10/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import Foundation
import XCTest
@testable import CityRanks

final class CitiesInteractorTests: XCTestCase {

    private var dataManager: FakeCitiesRepository!
    private var imageFetcher: FakeImageFetcher!
    private var storage: FakeCityStorage!
    private var presenter: CitiesPresenterSpy!
    private var interactor: CitiesInteractor<FakeCityStorage>!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        dataManager = FakeCitiesRepository()
        imageFetcher = FakeImageFetcher()
        storage = FakeCityStorage()
        presenter = CitiesPresenterSpy()
        interactor = CitiesInteractor(dataManager: dataManager, imageFetcher: imageFetcher, storage: storage)
        interactor.presenter = presenter
    }

    func testFetchCities_whenIsSuccessful_thenPresentsCities() {
        interactor.fetchCities()
        
        XCTAssertTrue(presenter.citiesToPresent == dataManager.cities.sorted())
    }
    
    func testFetchCities_withRefresh_thenPresentsLastFetchedCities() {
        interactor.fetchCities()
        dataManager.cities = []
        interactor.fetchCities(refresh: true)
        
        XCTAssertEqual(presenter.citiesToPresent, [])
        
        dataManager.cities = [City.warsaw]
        interactor.fetchCities(refresh: true)
        
        XCTAssertEqual(presenter.citiesToPresent, [City.warsaw])
    }
    
    func testFetchCities_withNoRefresh_thenPresentsLastFetchedCities() {
        let cities = dataManager.cities
        
        interactor.fetchCities()
        dataManager.cities = []
        interactor.fetchCities(refresh: false)
        
        XCTAssertEqual(presenter.citiesToPresent, cities.sorted())
    }
    
    func testFetchCities_withError_thenPresentsAlert() {
        let error: Error = NSError()
        
        dataManager.error = error
        interactor.fetchCities()

        XCTAssertTrue(presenter.errorToShow as AnyObject? === error as AnyObject)
    }

}

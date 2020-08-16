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

    private var repository: FakeCityRepository!
    private var imageFetcher: FakeImageFetcher!
    private var storage: CityStorage!
    private var presenter: CitiesPresenterSpy!
    private var interactor: CitiesInteractor!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        repository = FakeCityRepository()
        imageFetcher = FakeImageFetcher()
        storage = CityStorage(fake: true)
        presenter = CitiesPresenterSpy()
        interactor = CitiesInteractor(repository: repository, imageFetcher: imageFetcher, storage: storage)
        interactor.presenter = presenter
    }

    func testFetchCities_whenIsSuccessful_thenPresentsCities() {
        interactor.fetchCities()
        
        XCTAssertTrue(presenter.citiesToPresent == repository.cities)
    }
    
    func testFetchCities_withRefresh_thenPresentsLastFetchedCities() {
        interactor.fetchCities()
        repository.cities = []
        interactor.fetchCities(refresh: true)
        
        XCTAssertEqual(presenter.citiesToPresent, [])
        
        repository.cities = [[City].polish.first!]
        interactor.fetchCities(refresh: true)
        
        XCTAssertEqual(presenter.citiesToPresent, repository.cities)
    }
    
    func testFetchCities_withNoRefresh_thenPresentsLastFetchedCities() {
        let cities = repository.cities
        
        interactor.fetchCities()
        repository.cities = []
        interactor.fetchCities(refresh: false)
        
        XCTAssertEqual(presenter.citiesToPresent, cities)
    }
    
    func testFetchCities_withError_thenPresentsAlert() {
        let error: Error = NSError()
        
        repository.error = error
        interactor.fetchCities()

        XCTAssertTrue(presenter.errorToShow as AnyObject? === error as AnyObject)
    }

}

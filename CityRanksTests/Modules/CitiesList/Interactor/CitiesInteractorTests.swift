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

final class PlacesInteractorTests: XCTestCase {

    private var dataManager: CitiesRepositoryFake!
    private var presenter: CitiesPresenterSpy!
    private var interactor: CitiesInteractor!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        dataManager = CitiesRepositoryFake()
        presenter = CitiesPresenterSpy()
        interactor = CitiesInteractor(dataManager: dataManager)
        interactor.presenter = presenter
    }

    func testFetchCities_whenIsSuccessful_thenPresentsCities() {
        dataManager.citiesToHandle = .polish

        interactor.fetchCities()
        
        XCTAssertTrue(presenter.citiesToPresent == dataManager.citiesToHandle)
    }

}

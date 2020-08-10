//
//  CitiesPresenterTests.swift
//  CityRanksTests
//
//  Created by lyzkov on 07/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import XCTest
@testable import CityRanks

final class CitiesPresenterTests: XCTestCase {
    
    private var view: CitiesViewSpy!
    private var interactor: CitiesInteractorSpy!
    private var wireframe: WireframeSpy!
    private var presenter: CitiesPresenter!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        view = CitiesViewSpy()
        interactor = CitiesInteractorSpy()
        wireframe = WireframeSpy()
        presenter = CitiesPresenter(wireframe: wireframe, view: view, interactor: interactor)
    }
    
    func testLoad_fetchesCitiesFromInteractor() {
        presenter.load()

        XCTAssertTrue(interactor.didFetch)
    }
    
    func testPresentCities_rendersCitiesInView() {
        let cities: [City] = .polish

        presenter.present(cities: cities)

        XCTAssertEqual(cities, view.didRenderCities)
        XCTAssertFalse(wireframe.didPresentAlert)
    }

}

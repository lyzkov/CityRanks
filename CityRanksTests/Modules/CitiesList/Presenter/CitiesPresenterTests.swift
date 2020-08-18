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
        interactor.presenter = presenter
    }
    
    func testLoadCities_fetchesCitiesFromInteractor() {
        presenter.loadCities()

        XCTAssertTrue(interactor.didFetchCities)
    }
    
    func testPresentCities_rendersCitiesInView() {
        let cities: [City] = .polish

        presenter.present(cities: cities)

        XCTAssertTrue(view.didRenderCitiesList)
        XCTAssertFalse(wireframe.didPresentAlert)
    }
    
    func testLoadCityImage_fetchesImageFromInteractor() {
        interactor.citiesToPresent = .polish
        
        presenter.loadCities()
        presenter.loadCityImage(forRowAt: IndexPath(item: 0, section: 0))
        
        XCTAssertTrue(interactor.didFetchImage)
    }
    
    func testPresentImage_rendersImageInView() {
        interactor.citiesToPresent = .polish
        let city = interactor.citiesToPresent[2]
        
        presenter.loadCities()
        presenter.presentImage(city: city)
        
        XCTAssertTrue(view.didRenderCityImageIndexPath == IndexPath(item: 2, section: 0))
        XCTAssertFalse(wireframe.didPresentAlert)
    }
    
    func testFilterCities_presentsFavoriteCitiesOnly() {
        var polish = [City].polish
        polish[1].favorite = true
        interactor.citiesToPresent = polish
        
        presenter.loadCities()
        
        XCTAssertEqual(presenter.numberOfRows, polish.count)
        
        presenter.filterCities(favorites: true)
        
        XCTAssertEqual(presenter.numberOfRows, 1)
        
        presenter.filterCities(favorites: false)
        
        XCTAssertEqual(presenter.numberOfRows, polish.count)
    }
    
    func testToggleFavorite_updatesCity() {
        let cities = [City].polish
        interactor.citiesToPresent = cities
        
        presenter.loadCities()
        presenter.toggleFavorite(forRowAt: IndexPath(item: 1, section: 0))
        
        XCTAssertEqual(interactor.didUpdateCity, cities[1])
    }
    
    func testShowAlert_presentsAlertFromError() {
        let error: Error = NSError()
        
        presenter.showAlert(from: error)
        
        XCTAssertTrue(wireframe.didPresentAlert)
        XCTAssertTrue(wireframe.error as AnyObject? === error as AnyObject)
    }

}

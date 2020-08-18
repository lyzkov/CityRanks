//
//  CityDetailsPresenter.swift
//  CityRanks
//
//  Created by lyzkov on 17/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import Foundation

protocol VisitorsViewDataSource {
    var numberOfRows: Int { get }
    func visitor(for indexPath: IndexPath) -> VisitorRenderable
}

protocol CityDetailsPresenterInputProtocol: class, VisitorsViewDataSource {
    func loadCityDetails()
    func loadCityImage()
}

protocol CityDetailsPresenterOutputProtocol: class {
    func present(cityDetails: City)
    func showAlert(from error: Error)
}

final class CityDetailsPresenter {
    
    private let wireframe: CityDetailsWireframeProtocol
    private weak var view: CityDetailsViewProtocol!
    private let interactor: CityDetailsInteractorProtocol
    
    private var city: City
    
    init(wireframe: CityDetailsWireframeProtocol, view: CityDetailsViewProtocol, interactor: CityDetailsInteractorProtocol, city: City) {
        self.wireframe = wireframe
        self.view = view
        self.interactor = interactor
        self.city = city
    }
    
}

extension CityDetailsPresenter: CityDetailsPresenterInputProtocol {
    
    func loadCityDetails() {
        interactor.fetchDetails(for: city)
        view.render(cityDetails: city)
    }
    
    func loadCityImage() {
        interactor.fetchImage(for: city)
    }
    
}

extension CityDetailsPresenter: CityDetailsPresenterOutputProtocol {
    
    func present(cityDetails: City) {
        city = cityDetails
        view.render(cityDetails: cityDetails)
    }
    
    func showAlert(from error: Error) {
        wireframe.presentAlert(from: error)
    }
    
}

extension CityDetailsPresenter: VisitorsViewDataSource {
    
    var numberOfRows: Int {
        return city.visitors?.count ?? 0
    }
    
    func visitor(for indexPath: IndexPath) -> VisitorRenderable {
        return city.visitors![indexPath.row]
    }
    
}

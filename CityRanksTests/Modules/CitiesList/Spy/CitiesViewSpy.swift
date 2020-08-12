//
//  CitiesViewSpy.swift
//  CityRanksTests
//
//  Created by lyzkov on 07/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import Foundation
@testable import CityRanks

final class CitiesViewSpy: CitiesViewProtocol {
    
    var presenter: CitiesPresenterInputProtocol!
    
    var didRenderCitiesList = false
    
    func renderCitiesList() {
        didRenderCitiesList = true
    }
    
    var didRenderCityImageIndexPath: IndexPath? = nil
    
    func renderCityImage(forRowAt indexPath: IndexPath) {
        didRenderCityImageIndexPath = indexPath
    }
    


}

//
//  City.swift
//  CityRanks
//
//  Created by lyzkov on 06/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import Foundation

struct City {
    let name: String
    let favorite: Bool
    let image: URL
}

extension City: Equatable {
    
}

extension City {
    
    static let warsaw = City(name: "Warszawa", favorite: true, image:  "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b5/POL_Warszawa_COA.svg/286px-POL_Warszawa_COA.svg.png")
    
    static let wroclaw = City(name: "Wrocław", favorite: true, image:  "https://upload.wikimedia.org/wikipedia/commons/thumb/0/07/Herb_wroclaw.svg/404px-Herb_wroclaw.svg.png")
    
    static let cracow = City(name: "Kraków", favorite: true, image: "https://upload.wikimedia.org/wikipedia/commons/thumb/4/41/POL_Krak%C3%B3w_COA.svg/1200px-POL_Krak%C3%B3w_COA.svg.png")
    
}

extension Array where Element == City {
    
    static let polish = [City.wroclaw, City.warsaw, City.cracow]
    
}

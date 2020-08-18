//
//  CityFixture.swift
//  CityRanks
//
//  Created by lyzkov on 18/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import Foundation

struct CityFixture: Codable {
    let id: Int
    let name: String
    let image: URL
    let visitors: [UserFixture]
}

extension City {
    
    init(from fixture: CityFixture) {
        self.init(
            id: fixture.id,
            name: fixture.name,
            imageData: .placeholder(url: fixture.image),
            visitors: fixture.visitors.map(User.init(from:))
        )
        
    }
    
}

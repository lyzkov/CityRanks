//
//  UserFixture.swift
//  CityRanks
//
//  Created by lyzkov on 18/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import Foundation

struct UserFixture: Codable {
    let name: String
}

extension User {
    
    init(from fixture: UserFixture) {
        name = fixture.name
    }
    
}

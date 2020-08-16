//
//  City.swift
//  CityRanks
//
//  Created by lyzkov on 06/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import Foundation
import ImageFetcher

struct City: Codable {
    let id: Int
    var name: String! = nil
    var favorite: Bool = false
    var imageData: ImageResource! = nil
}

extension City {
    
    init(id: Int, name: String, imageUrl: URL) {
        self.id = id
        self.name = name
        self.imageData = .placeholder(url: imageUrl)
    }
    
}

extension City: Equatable {
    static func == (lhs: City, rhs: City) -> Bool {
        return lhs.id == rhs.id
    }
}

extension City: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension City: Comparable {
    
    static func < (lhs: City, rhs: City) -> Bool {
        return lhs.id < rhs.id
    }
    
}

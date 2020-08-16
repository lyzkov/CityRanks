//
//  City.swift
//  CityRanks
//
//  Created by lyzkov on 06/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import Foundation
import Storage
import ImageFetcher

struct City: Codable {
    let id: Int
    var name: String! = nil
    var favorite: Bool = false
    var imageData: ImageResource! = nil
}

extension City: Storable {
    
    var storingKey: String {
        return String(id)
    }
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case favorite
    }
    
    mutating func update(with restored: Self) throws {
        favorite = restored.favorite
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

extension City {
    
    init(id: Int, name: String, imageUrl: URL) {
        self.id = id
        self.name = name
        self.imageData = .placeholder(url: imageUrl)
    }
    
    static let warsaw = City(id: 1, name: "Warszawa", imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b5/POL_Warszawa_COA.svg/286px-POL_Warszawa_COA.svg.png")
    
    static let wroclaw = City(id: 2, name: "Wrocław", imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/07/Herb_wroclaw.svg/404px-Herb_wroclaw.svg.png")
    
    static let cracow = City(id: 3, name: "Kraków", imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/4/41/POL_Krak%C3%B3w_COA.svg/1200px-POL_Krak%C3%B3w_COA.svg.png")
    
}

extension Array where Element == City {
    
    static let polish = [
        City.wroclaw,
        City.warsaw,
        City.cracow,
    ]
    
}

final class CityStorage: StorageProtocol {
    
    private let storage = UserDefaultsStorage<City>(name: "Cities")!
    
    private let fake: Bool
    
    init(fake: Bool = false) {
        self.fake = fake
    }
    
    func store(_ entity: City) throws {
        if !fake {
            try storage.store(entity)
        }
    }
    
    func restore(_ entity: inout City) throws {
        if !fake {
            try storage.restore(&entity)
        }
    }
}

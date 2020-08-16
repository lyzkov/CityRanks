//
//  CityStorage.swift
//  CityRanks
//
//  Created by lyzkov on 16/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import Foundation
import Storage

/// TODO: replace below erasure type with opaque type introduced in iOS13
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

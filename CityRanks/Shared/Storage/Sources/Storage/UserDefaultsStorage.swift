//
//  UserDefaultsStorage.swift
//  CityRanks
//
//  Created by lyzkov on 12/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import Foundation

public final class UserDefaultsStorage<Entity: Storable>: Storage {
    
    private let localStorage: UserDefaults
    
    private let encoder = JSONEncoder()
    
    private let decoder = JSONDecoder()
    
    public init?(name: String) {
        guard let localStorage = UserDefaults(suiteName: name) else {
            return nil
        }
        self.localStorage = localStorage
    }
    
    public func store(_ entity: Entity) throws {
        try localStorage.set(encoder.encode(entity), forKey: entity.storingKey)
    }
    
    public func restore(_ entity: inout Entity) throws {
        guard let data = localStorage.data(forKey: entity.storingKey) else {
            return
        }
        try entity.update(with: decoder.decode(Entity.self, from: data))
    }
    
}

//
//  OrderedSet.swift
//  CityRanks
//
//  Created by lyzkov on 14/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import Foundation

extension OrderedSet {
    
    @discardableResult mutating func update(with object: Element) -> Index? {
        guard let index = remove(object) else {
            return nil
        }
        insert(object, at: index)
        
        return index
    }
    
}

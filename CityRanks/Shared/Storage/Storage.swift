//
//  Storage.swift
//  CityRanks
//
//  Created by lyzkov on 12/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import Foundation

protocol Storage {
    associatedtype Entity: Storable
    
    func store(_ entity: Entity) throws
    func restore(_ entity: inout Entity) throws
}

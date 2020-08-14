//
//  Storable.swift
//  CityRanks
//
//  Created by lyzkov on 12/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import Foundation

protocol Storable: Codable, Identifiable where RawRepresentation: LosslessStringConvertible {
    mutating func update(with restored: Self) throws
}

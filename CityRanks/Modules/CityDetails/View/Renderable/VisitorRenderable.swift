//
//  VisitorRenderable.swift
//  CityRanks
//
//  Created by lyzkov on 18/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import Foundation

protocol VisitorRenderable {
    var name: String { get }
}

extension User: VisitorRenderable {
}

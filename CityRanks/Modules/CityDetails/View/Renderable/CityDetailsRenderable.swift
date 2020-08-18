//
//  CityDetailsRenderable.swift
//  CityRanks
//
//  Created by lyzkov on 18/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import Foundation
import UIKit

protocol CityDetailsRenderable {
    var name: String! { get }
    var image: UIImage? { get }
    func getVisitors() -> [VisitorRenderable]?
}

extension City: CityDetailsRenderable {
    
    func getVisitors() -> [VisitorRenderable]? {
        return visitors
    }
    
}

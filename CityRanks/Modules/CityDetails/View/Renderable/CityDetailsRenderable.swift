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
    var numberOfVisitors: Int? { get }
}

extension City: CityDetailsRenderable {
    
    var numberOfVisitors: Int? {
        return visitors?.count
    }
    
}

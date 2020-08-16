//
//  CityRenderable.swift
//  CityRanks
//
//  Created by lyzkov on 12/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import Foundation
import UIKit

protocol CityRenderable {
    var name: String! { get }
    var favorite: Bool { get }
    var image: UIImage? { get }
}

extension City: CityRenderable {
    
    var image: UIImage? {
        return UIImage(from: imageData)
    }
    
}

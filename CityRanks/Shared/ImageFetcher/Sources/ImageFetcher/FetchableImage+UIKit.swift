//
//  FetchableImage+UIKit.swift
//  CityRanks
//
//  Created by lyzkov on 12/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import Foundation
import UIKit

public extension UIImage {
    
    convenience init?(from resource: ImageResource) {
        guard case .loaded(let data) = resource else {
            return nil
        }
        
        self.init(data: data)
    }
    
}

//
//  FetchableImage.swift
//  CityRanks
//
//  Created by lyzkov on 10/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import Foundation

enum FetchableImage {
    case placeholder(url: URL)
    case loadingPlaceholder
    case loaded(image: Data)
    case failure(error: Error)
    
    var data: Data? {
        switch self {
        case .placeholder, .loadingPlaceholder, .failure:
            return nil
        case .loaded(let image):
            return image
        }
    }
    
}

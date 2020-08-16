//
//  ImageResource.swift
//  CityRanks
//
//  Created by lyzkov on 10/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import Foundation

public enum ImageResource {
    case placeholder(url: URL)
    case loadingPlaceholder
    case loaded(image: Data)
    case failure(error: Error)
}

//
//  ServiceLocator.swift
//  CityRanks
//
//  Created by lyzkov on 16/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import Foundation
import ImageFetcher
import Storage

private let fake = true

enum ServiceLocator {
    
    static let cityRepository: CitiesRepositoryProtocol = FakeCitiesRepository()
    
    static let urlSession: URLSession = URLSession.shared
    
    static let imageFetcher: ImageFetcherProtocol = fake ? FakeImageFetcher() : ImageFetcher(urlSession: ServiceLocator.urlSession)
    
    static let cityStorage = CityStorage(fake: fake)
    
}

//
//  ImageFetcher.swift
//  CityRanks
//
//  Created by lyzkov on 10/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import Foundation

class ImageFetcher {
    
    func fetch(from url: URL, completion handler: (Result<Data, Error>) -> Void) {
        
    }
    
    func fetch(from url: URL, completion handler: @escaping (FetchableImage) -> Void) {
        handler(.loadingPlaceholder)
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                DispatchQueue.main.async {
                    handler(.loaded(image: data))
                }
            } catch {
                DispatchQueue.main.async {
                    handler(.failure(error: error))
                }
            }
        }
    }
    
}

//
//  ImageFetcher.swift
//  CityRanks
//
//  Created by lyzkov on 10/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import Foundation

protocol ImageFetcherProtocol {
    func fetch(from url: URL, completion handler: @escaping (FetchableImage) -> Void)
    func fetch(from url: URL, completion handler: @escaping (Result<Data, Error>) -> Void)
}

final class ImageFetcher: ImageFetcherProtocol {
    
    func fetch(from url: URL, completion handler: @escaping (FetchableImage) -> Void) {
        handler(.loadingPlaceholder)
        fetch(from: url) { (result: Result<Data, Error>) in
            switch result {
            case .success(let data):
                handler(.loaded(image: data))
            case .failure(let error):
                handler(.failure(error: error))
            }
        }
    }
    
    func fetch(from url: URL, completion handler: @escaping (Result<Data, Error>) -> Void) {
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                DispatchQueue.main.async {
                    handler(.success(data))
                }
            } catch {
                DispatchQueue.main.async {
                    handler(.failure(error))
                }
            }
        }
    }
    
}

//
//  ImageFetcher.swift
//  CityRanks
//
//  Created by lyzkov on 10/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import Foundation

public protocol ImageFetcherProtocol {
    func fetch(from url: URL, completion handler: @escaping (ImageResource) -> Void)
    func fetch(from url: URL, completion handler: @escaping (Result<Data, Error>) -> Void)
}

public final class ImageFetcher: ImageFetcherProtocol {
    
    private let urlSession: URLSession
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    public func fetch(from url: URL, completion handler: @escaping (ImageResource) -> Void) {
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
    
    public func fetch(from url: URL, completion handler: @escaping (Result<Data, Error>) -> Void) {
        urlSession.dataTask(with: url) { data, response, error in
            if let error = error {
                handler(.failure(error))
            } else if let data = data {
                handler(.success(data))
            }
        }
    }
    
}

//
//  FakeImageFetcher.swift
//  CityRanks
//
//  Created by lyzkov on 11/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import Foundation
import UIKit
import ImageFetcher

final class FakeImageFetcher: ImageFetcherProtocol {
    
    var imageData: [String: UIImage]
    
    init(fixtures: FixturesLoader<[String: String]> = .init()) {
        let names = try? fixtures.load(resource: "ImageURLAssets")
        self.imageData = names?.compactMapValues(UIImage.init(named:)) ?? [:]
    }
    
    func fetch(from url: URL, completion handler: @escaping (ImageResource) -> Void) {
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
        DispatchQueue.global().async { [weak self] in
            guard let data = self?.imageData[url.absoluteString]?.jpegData(compressionQuality: 0.89) else {
                DispatchQueue.main.async {
                    handler(.failure(NSError()))
                }
                return
            }
            DispatchQueue.main.async {
                handler(.success(data))
            }
        }
    }
    
}

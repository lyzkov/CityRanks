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

private let cityImages = isRunningTests ?
    [UIImage(), UIImage(), UIImage()] :
    [UIImage(named: "cracow")!, UIImage(named: "wroclaw")!, UIImage(named: "warsaw")!]

final class FakeImageFetcher: ImageFetcherProtocol {
    
    var imageData: [UIImage]
    
    init(imageData: [UIImage] = cityImages) {
        self.imageData = imageData
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
            guard let data = self?.imageData.popLast()?.jpegData(compressionQuality: 0.89) else {
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

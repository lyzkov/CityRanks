//
//  UIImage+Placeholder.swift
//  CityRanks
//
//  Created by lyzkov on 16/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    static var placeholder: UIImage = {
        let placeholderRectangle = UIView(frame: .init(x: 0, y: 0, width: 20, height: 20))
        placeholderRectangle.backgroundColor = .gray
        
        return placeholderRectangle.asImage()
    }()
    
}

fileprivate extension UIView {

    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)

        return renderer.image {
            rendererContext in

            layer.render(in: rendererContext.cgContext)
        }
    }
}

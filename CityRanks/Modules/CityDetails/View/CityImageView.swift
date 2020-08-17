//
//  CityImageView.swift
//  CityRanks
//
//  Created by lyzkov on 18/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import Foundation
import UIKit

final class CityImageView: UIImageView {
    
    private enum Default {
        static let size: CGFloat = 100.0
    }
    
    lazy var sizeConstraint = heightAnchor.constraint(equalToConstant: Default.size)
    
    init() {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        image = .placeholder
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalTo: heightAnchor),
            sizeConstraint,
        ])
    }
    
}

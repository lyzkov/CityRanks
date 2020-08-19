//
//  CityNameLabel.swift
//  CityRanks
//
//  Created by lyzkov on 18/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import Foundation
import UIKit

final class CityNameLabel: UILabel {
    
    private enum Default {
        static let height: CGFloat = 60.0
    }
    
    lazy var heightConstraint = heightAnchor.constraint(equalToConstant: Default.height)
    
    init() {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        textAlignment = .center
        textColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        guard let superview = superview else { return }
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalTo: superview.widthAnchor),
            heightConstraint,
        ])
    }
    
}

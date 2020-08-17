//
//  CityDetailsStack.swift
//  CityRanks
//
//  Created by lyzkov on 18/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import Foundation
import UIKit

final class CityDetailsStack: UIStackView {
    
    init(cityImageView: CityImageView, cityNameLabel: CityNameLabel) {
        super.init(frame: .zero)

        translatesAutoresizingMaskIntoConstraints = false

        axis = .vertical
        distribution = .equalSpacing
        alignment = .center
        
        addArrangedSubview(cityImageView)
        addArrangedSubview(cityNameLabel)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        guard let superview = superview else { return }
        
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: superview.centerXAnchor),
            topAnchor.constraint(equalTo: superview.layoutMarginsGuide.topAnchor),
            widthAnchor.constraint(equalTo: superview.layoutMarginsGuide.widthAnchor),
        ])
    }
    
}

//
//  CityDetailsView.swift
//  CityRanks
//
//  Created by lyzkov on 17/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import UIKit

protocol CityDetailsViewProtocol: class {
    var presenter: CityDetailsPresenterInputProtocol! { get set }
    
    func render(city: CityRenderable)
}

final class CityDetailsView: UIViewController, CityDetailsViewProtocol {
    
    private enum Default {
        static let backgroundColor: UIColor = .white
        static let marginTop: CGFloat = 100.0
        static let marginHorizontal: CGFloat = 100.0
    }
    
    var presenter: CityDetailsPresenterInputProtocol!
    
    private lazy var cityNameLabel = CityNameLabel()
    private lazy var cityImageView = CityImageView()
    private lazy var cityDetailsStack = CityDetailsStack(cityImageView: cityImageView, cityNameLabel: cityNameLabel)
    
    override func loadView() {
        super.loadView()
        
        configureView()
        
        view.addSubview(cityDetailsStack)
    }
    
    private func configureView() {
        view.backgroundColor = Default.backgroundColor
        view.layoutMargins.top = Default.marginTop
        view.layoutMargins.left = Default.marginHorizontal
        view.layoutMargins.right = Default.marginHorizontal
    }
    
    func render(city: CityRenderable) {
        cityNameLabel.text = city.name
        cityImageView.image = city.image
    }

}

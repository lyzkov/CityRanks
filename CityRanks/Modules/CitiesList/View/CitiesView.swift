//
//  CitiesView.swift
//  CityRanks
//
//  Created by lyzkov on 06/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import UIKit

protocol CitiesViewProtocol {
    var presenter: CitiesPresenterInputProtocol! { get set }
    func renderCitiesList()
    func renderCityImage(forRowAt indexPath: IndexPath)
}

final class CitiesView: UITableViewController, CitiesViewProtocol {
    
    // MARK: - Dependencies
    
    var presenter: CitiesPresenterInputProtocol!
    
    // MARK: - Properties
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cityCell")
        
        tableView.prefetchDataSource = self
        
        presenter?.loadCities()
    }
    
    // MARK: - Protocol implementations
    
    func renderCitiesList() {
        tableView.reloadData()
    }
    
    func renderCityImage(forRowAt indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
}

// MARK: - Table View Delegate implementations

extension CitiesView {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath)
        cell.textLabel?.text = presenter.city(for: indexPath).name
        cell.imageView?.image = presenter.city(for: indexPath).image ?? .placeholder
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if presenter.city(for: indexPath).image == nil {
            presenter.loadCityImage(forRowAt: indexPath)
        }
    }
    
}

extension CitiesView: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if presenter.city(for: indexPath).image == nil {
                presenter.loadCityImage(forRowAt: indexPath)
            }
        }
    }
    
}

protocol CityRenderable {
    var name: String { get }
    var image: UIImage? { get }
}

extension City: CityRenderable {
    
    var image: UIImage? {
        switch imageData {
        case .loaded(let data):
            return UIImage(data: data) ?? .placeholder
        case .loadingPlaceholder, .failure:
            return .placeholder
        default:
            return nil
        }
    }
    
}

extension UIView {

    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)

        return renderer.image {
            rendererContext in

            layer.render(in: rendererContext.cgContext)
        }
    }
}

extension UIImage {
    
    static var placeholder: UIImage = {
        let placeholderRectangle = UIView(frame: .init(x: 0, y: 0, width: 20, height: 20))
        placeholderRectangle.backgroundColor = .gray
        
        return placeholderRectangle.asImage()
    }()
    
}

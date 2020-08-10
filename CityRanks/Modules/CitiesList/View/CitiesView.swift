//
//  CitiesView.swift
//  CityRanks
//
//  Created by lyzkov on 06/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import UIKit

protocol CitiesViewProtocol {
    var presenter: CitiesPresenterInputProtocol?  { get set }
    func render(cities: [CityRenderable])
    func render(cityImage: CityImage, forRowAt indexPath: IndexPath)
}

final class CitiesView: UITableViewController, CitiesViewProtocol {
    
    // MARK: - Dependencies
    
    var presenter: CitiesPresenterInputProtocol?
    
    // MARK: - Properties
    
    private var cities: [CityRenderable] = []
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cityCell")
        
        tableView.prefetchDataSource = self
        
        presenter?.loadCities()
    }
    
    // MARK: - Protocol implementations
    
    func render(cities: [CityRenderable]) {
        self.cities = cities
        tableView.reloadData()
    }
    
    func render(cityImage: CityImage, forRowAt indexPath: IndexPath) {
        cities[indexPath.row].image = cityImage
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
}

// MARK: - Table View Delegate implementations

extension CitiesView {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath)
        cell.textLabel?.text = cities[indexPath.item].name
        cell.imageView?.image = cities[indexPath.item].image.image
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if case let .placeholder(url) = cities[indexPath.row].image {
            presenter?.loadCityImage(from: url, forRowAt: indexPath)
        }
    }
    
}

extension CitiesView: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if case let .placeholder(url) = cities[indexPath.row].image {
                presenter?.loadCityImage(from: url, forRowAt: indexPath)
            }
        }
    }
    
}

struct CityRenderable {
    let name: String
    var image: CityImage
}

extension CityRenderable {
    
    init(from city: City) {
        name = city.name
        image = .placeholder(url: city.image)
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
    
    static func placeholder() -> UIImage {
        let placeholderRectangle = UIView(frame: .init(x: 0, y: 0, width: 20, height: 20))
        placeholderRectangle.backgroundColor = .gray
        
        return placeholderRectangle.asImage()
    }
    
}

enum CityImage {
    case placeholder(url: URL)
    case loading
    case loaded(image: UIImage)
    
    var image: UIImage {
        switch self {
        case .placeholder, .loading:
            return .placeholder()
        case .loaded(let image):
            return image
        }
    }
    
    init?(from data: Data) {
        guard let image = UIImage(data: data) else {
            return nil
        }
        self = CityImage.init(from: image)
    }
    
    init(from image: UIImage) {
        self = .loaded(image: image)
    }
}

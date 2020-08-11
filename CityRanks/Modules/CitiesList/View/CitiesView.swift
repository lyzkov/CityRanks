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
    
    // MARK: - Subviews
    
    var favoriteIcon: UIImageView {
        UIImageView(image: "💛".image())
    }
    
    // MARK: - Properties
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation Bar setup
        title = "Cities Rank"
        
        let favoritesLabel = UILabel()
        favoritesLabel.text = "Fav"
        let favoritesSwitch = UISwitch()
        favoritesSwitch.addTarget(self, action: #selector(favoriteDidChange), for: .valueChanged)
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: favoritesSwitch), UIBarButtonItem(customView: favoritesLabel)]
        
        // Table View setup
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cityCell")
        
        tableView.prefetchDataSource = self
        
        // Data feed
        presenter?.loadCities()
    }
    
    @objc func favoriteDidChange(sender: UISwitch!) {
        presenter.filterCities(favorites: sender.isOn)
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
        let city = presenter.city(for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath)
        cell.textLabel?.text = city.name
        cell.imageView?.image = city.image ?? .placeholder
        cell.accessoryView = city.favorite ? favoriteIcon : nil
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if presenter.city(for: indexPath).image == nil {
            presenter.loadCityImage(forRowAt: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [
            .init(style: .normal, title: "Favorite", handler: { action, view, success in
                self.presenter.toggleFavorite(forRowAt: indexPath)
                success(true)
            })
        ])
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
    var favorite: Bool { get }
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

extension String {
    
    func image(fontSize: CGFloat = 15, bgColor: UIColor = UIColor.clear, imageSize: CGSize? = nil) -> UIImage? {
        let font = UIFont.systemFont(ofSize: fontSize)
        let attributes = [NSAttributedString.Key.font: font]
        let imageSize = imageSize ?? self.size(withAttributes: attributes)

        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0)
        bgColor.set()
        let rect = CGRect(origin: .zero, size: imageSize)
        UIRectFill(rect)
        self.draw(in: rect, withAttributes: [.font: font])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
}

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
    
    private enum Default {
        static let cityCellId = "cityCell"
        static let favoriteIcon = "💛"
        static let favSwitchTitle = "Fav"
        static let title = "Cities Rank"
    }
    
    // MARK: - Dependencies
    
    var presenter: CitiesPresenterInputProtocol!
    
    // MARK: - Subviews
    
    var favoriteIcon: UIImageView {
        UIImageView(image: Default.favoriteIcon.image())
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation Bar setup
        title = Default.title
        
        let favoritesLabel = UILabel()
        favoritesLabel.text = Default.favSwitchTitle
        let favoritesSwitch = UISwitch()
        favoritesSwitch.addTarget(self, action: #selector(favoriteDidChange), for: .valueChanged)
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: favoritesSwitch), UIBarButtonItem(customView: favoritesLabel)]
        
        // Table View setup
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Default.cityCellId)
        
        tableView.prefetchDataSource = self
        tableView.activityIndicatorView.style = .large
        tableView.activityIndicatorView.startAnimating()
        
        // Data feed
        presenter?.loadCities()
    }
    
    @objc func favoriteDidChange(sender: UISwitch!) {
        presenter.filterCities(favorites: sender.isOn)
    }
    
    // MARK: - Protocol implementations
    
    func renderCitiesList() {
        tableView.reloadData()
        tableView.activityIndicatorView.stopAnimating()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: Default.cityCellId, for: indexPath)
        cell.textLabel?.text = city.name
        if let image = city.image {
            cell.imageView?.activityIndicatorView.stopAnimating()
            cell.imageView?.image = image
        } else {
            cell.imageView?.activityIndicatorView.startAnimating()
            cell.imageView?.image = .placeholder
        }
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
            .init(style: .normal, title: Default.favoriteIcon, handler: { action, view, success in
                self.presenter.toggleFavorite(forRowAt: indexPath)
                success(true)
            })
        ])
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.showDetails(forRowAt: indexPath)
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

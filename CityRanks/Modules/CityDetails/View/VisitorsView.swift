//
//  VisitorsView.swift
//  CityRanks
//
//  Created by lyzkov on 19/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import UIKit

final class VisitorsView: UITableViewController {
    
    private enum Default {
        static let visitorCellId = "visitorCell"
    }
    
    var presenter: CityDetailsPresenterInputProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Default.visitorCellId)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Default.visitorCellId, for: indexPath)
        
        cell.textLabel?.text = presenter.visitor(for: indexPath).name

        return cell
    }

}

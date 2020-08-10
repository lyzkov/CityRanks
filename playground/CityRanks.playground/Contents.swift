//: Quick and dirty prototype that fetches cities data from mocking server and shows in list
  
import Foundation
import UIKit
import PlaygroundSupport

// MARK: - Parameters

let apiURL = URL(string: "https://15e1d0d8-3ad2-4781-88b7-95e2163b86f7.mock.pstmn.io/cities")!

// MARK: - Model

struct City: Codable {
    let id: Int
    let name: String
    let image: String
}

typealias Cities = [City]

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

// MARK: - Fetching cities

extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }

    func citiesTask(with url: URL, completionHandler: @escaping (Cities?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}

// MARK: - Showing cities data on UI

class CityListViewController: UITableViewController {
    
    private var cities: Cities = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cityCell")
        
        let fetchCities = URLSession.shared.citiesTask(with: apiURL) { [weak self] cities, response, error in
            guard let cities = cities else {
                self?.cities = []
                self?.tableView.reloadData()
                
                return
            }
            
            self?.cities = cities
            self?.tableView.reloadData()
            
            if let error = error {
                let alert = UIAlertController(title: "Unexpected error", message: error.localizedDescription, preferredStyle: .alert)
                self?.present(alert, animated: true)
            }
        }
        
        fetchCities.resume()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.textLabel?.text = cities[indexPath.item].name
    }
    
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = CityListViewController()

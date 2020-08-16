//
//  FixturesLoader.swift
//  CityRanks
//
//  Created by lyzkov on 17/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import Foundation

final class FixturesLoader<Target: Decodable> {
    
    func load(resource: String) throws -> Target {
        guard let url = Bundle.main.url(forResource: resource, withExtension: "json") else { throw CocoaError(.fileNoSuchFile) }
        
        let jsonData = try Data(contentsOf: url)
        
        return (try JSONDecoder().decode(Target.self, from: jsonData))
    }
    
}

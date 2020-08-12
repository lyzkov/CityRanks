//
//  Identifiable.swift
//  CityRanks
//
//  Created by lyzkov on 12/08/2020.
//  Copyright © 2020 lyzkov. All rights reserved.
//

import Foundation

protocol Identifiable {
    associatedtype RawRepresentation = String
    typealias ID = Identifier<Self>
    
    var id: ID { get }
}

struct Identifier<Entity: Identifiable> {
    let rawValue: Entity.RawRepresentation

    init(rawValue: Entity.RawRepresentation) {
        self.rawValue = rawValue
    }
}

// MARK: - Integer literal support

extension Identifier: ExpressibleByIntegerLiteral where Entity.RawRepresentation: ExpressibleByIntegerLiteral {
    init(integerLiteral value: Entity.RawRepresentation.IntegerLiteralType) {
        rawValue = .init(integerLiteral: value)
    }
}

// MARK: - String literal support

extension Identifier: ExpressibleByUnicodeScalarLiteral where Entity.RawRepresentation: ExpressibleByUnicodeScalarLiteral {
    init(unicodeScalarLiteral value: Entity.RawRepresentation.UnicodeScalarLiteralType) {
        rawValue = .init(unicodeScalarLiteral: value)
    }
}

extension Identifier: ExpressibleByExtendedGraphemeClusterLiteral where Entity.RawRepresentation: ExpressibleByExtendedGraphemeClusterLiteral {
    init(extendedGraphemeClusterLiteral value: Entity.RawRepresentation.ExtendedGraphemeClusterLiteralType) {
        rawValue = .init(extendedGraphemeClusterLiteral: value)
    }
}

extension Identifier: ExpressibleByStringLiteral where Entity.RawRepresentation: ExpressibleByStringLiteral {
    init(stringLiteral value: Entity.RawRepresentation.StringLiteralType) {
        rawValue = .init(stringLiteral: value)
    }
}

// MARK: - Compiler-generated protocol support

extension Identifier: Equatable where Entity.RawRepresentation: Equatable {}
extension Identifier: Hashable where Entity.RawRepresentation: Hashable {}

// MARK: - Codable support

extension Identifier: Codable where Entity.RawRepresentation: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        rawValue = try container.decode(Entity.RawRepresentation.self)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}


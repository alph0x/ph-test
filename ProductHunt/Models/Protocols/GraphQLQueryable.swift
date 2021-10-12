//
//  GraphQLQueryable.swift
//  ProductHunt
//
//  Created by Alfredo E. Pérez Leal on 05/10/2021.
//

import SwiftyUtils

typealias GQLParameters = [GQLParameterKey: Any?]

protocol GraphQLQueryable {
    static func query(_ key: String, parameters: GQLParameters?) -> String
    static func compactQuery(_ key: String, parameters: GQLParameters?) -> String
}

// swiftlint:disable identifier_name
enum GQLParameterKey {
    case after
    case postConnection
    case postEdge
    case post
    case media
    case user
    case makers
    case id
    case votedPosts
}

extension Optional where Wrapped == GQLParameters {
    var asQuery: String {
        guard let params = self,
              params.values.filter({ return $0 != nil }).isNotEmpty else { return "" }
        let validParams = params.filter {
            guard ($0.value as? GQLParameters) != nil else { return true }
            return false
        }
        var paramBuilder = "("
        validParams.forEach {
            if let value = $1 {
                paramBuilder.append("\($0): \"\(value)\"")
            }
        }
        paramBuilder.append(")")
        return paramBuilder
    }

    func `for`(_ key: GQLParameterKey) -> GQLParameters? {
        guard let self = self else { return nil }
        return self[key] as? GQLParameters
    }
}

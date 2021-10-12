//
//  GraphQLBuilder.swift
//  ProductHunt
//
//  Created by Alfredo E. Pérez Leal on 05/10/2021.
//

import Foundation
import SwiftyUtils

enum GraphQLBuilder {
    case posts(after: String?)
    case post(identifier: String)
    case user(identifier: String)
    case postsForUser(identifier: String, after: String?)

    var data: Data? {
        return try? query.toData(options: .prettyPrinted)
    }

    private var query: [String: Any] {
        return [ "query": """
                    query {
                        \(structure)
                    }
        """.trimmingCharacters(in: .whitespacesAndNewlines)]
    }

    private var structure: String {
        switch self {
        case .posts(let after):
            return PostConnection.compactQuery("posts", parameters: [.after: after])
        case .post(let identifier):
            return Post.query("post", parameters: [.id: identifier])
        case .user(let identifier):
            return User.query("user", parameters: [.id: identifier])
        case .postsForUser(let identifier, let after):
            return User.postQuery("user", parameters: [.id: identifier,
                                                        GQLParameterKey.postConnection: [GQLParameterKey.after: after]])
        }
    }
}

extension PostConnection: GraphQLQueryable {
    static func compactQuery(_ key: String, parameters: GQLParameters?) -> String {
        return """
            \(key)\(parameters.asQuery) {
                \(PostEdge.compactQuery("edges", parameters: parameters.for(.postEdge)))
            }
        """
    }

    static func query(_ key: String, parameters: GQLParameters?) -> String {
        return """
            \(key)\(parameters.asQuery) {
                \(PostEdge.query("edges", parameters: parameters.for(.postEdge)))
            }
        """
    }
}

extension PostEdge: GraphQLQueryable {
    static func compactQuery(_ key: String, parameters: GQLParameters?) -> String {
        return """
            \(key)\(parameters.asQuery) {
                cursor
                \(Post.compactQuery("node", parameters: parameters.for(.post)))
            }
        """
    }

    static func query(_ key: String, parameters: GQLParameters?) -> String {
        return """
            \(key)\(parameters.asQuery) {
                cursor
                \(Post.query("node", parameters: parameters.for(.post)))
            }
        """
    }
}

extension Post: GraphQLQueryable {
    static func compactQuery(_ key: String, parameters: GQLParameters?) -> String {
        return """
            \(key)\(parameters.asQuery) {
                id
                name
                tagline
                votesCount
                \(Media.compactQuery("thumbnail", parameters: parameters.for(.media)))
                \(User.compactQuery("user", parameters: parameters.for(.user)))
            }
        """
    }

    static func query(_ key: String, parameters: GQLParameters?) -> String {
        return """
            \(key)\(parameters.asQuery) {
                id
                name
                \(User.query("makers", parameters: parameters.for(.makers)))
                tagline
                votesCount
                description
                \(Media.query("thumbnail", parameters: parameters.for(.media)))
                \(Media.query("media", parameters: parameters.for(.media)))
                \(User.query("user", parameters: parameters.for(.user)))
            }
        """
    }
}

extension Media: GraphQLQueryable {
    static func compactQuery(_ key: String, parameters: GQLParameters?) -> String {
        return query(key, parameters: parameters)
    }

    static func query(_ key: String, parameters: GQLParameters?) -> String {
        return """
            \(key)\(parameters.asQuery) {
                url
            }
        """
    }
}

extension User: GraphQLQueryable {
    static func compactQuery(_ key: String, parameters: GQLParameters?) -> String {
        return """
            \(key)\(parameters.asQuery) {
                id
                name
                username
                profileImage
            }
        """
    }

    static func query(_ key: String, parameters: GQLParameters?) -> String {
        return """
            \(key)\(parameters.asQuery) {
                headline
                id
                name
                username
                profileImage
                \(PostConnection.compactQuery("votedPosts", parameters: parameters.for(.postConnection)))
            }
        """
    }

    static func postQuery(_ key: String, parameters: GQLParameters?) -> String {
        return """
            \(key)\(parameters.asQuery) {
                id
                name
                \(PostConnection.compactQuery("votedPosts", parameters: parameters.for(.postConnection)))
            }
        """
    }
}

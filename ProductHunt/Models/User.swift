//
//  User.swift
//  ProductHunt
//
//  Created by Alfredo E. Pérez Leal on 05/10/2021.
//

import Foundation

class User: Codable, Detailable {
    var kind: DetailKind = .user

    var votedPosts: PostConnection?
    var headline: String?
    var identifier: String
    var name: String
    var username: String?
    var profileImage: String?

    required init(from decoder: Decoder) throws {
        let keyedContainer = try decoder.container(keyedBy: CodingKeys.self)
        headline = try? keyedContainer.decode(String.self, forKey: .headline)
        identifier = try keyedContainer.decode(String.self, forKey: .identifier)
        name = try keyedContainer.decode(String.self, forKey: .name)
        username = try? keyedContainer.decode(String.self, forKey: .username)
        profileImage = try? keyedContainer.decode(String.self, forKey: .profileImage)
        votedPosts = try? keyedContainer.decode(PostConnection.self, forKey: .votedPosts)
    }

    private enum CodingKeys: String, CodingKey {
        case headline
        case identifier = "id"
        case name
        case username
        case profileImage
        case votedPosts
    }
}

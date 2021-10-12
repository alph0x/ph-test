//
//  Post.swift
//  ProductHunt
//
//  Created by Alfredo E. Pérez Leal on 05/10/2021.
//

import Foundation

class Post: Codable {
    var identifier: String
    var name: String
    var tagline: String
    var votesCount: Int
    var thumbnail: Media
    var user: User
    var description: String?
    var makers: [User]?
    var media: [Media]?

    required init(from decoder: Decoder) throws {
        let keyedContainer = try decoder.container(keyedBy: CodingKeys.self)
        identifier = try keyedContainer.decode(String.self, forKey: .identifier)
        name = try keyedContainer.decode(String.self, forKey: .name)
        tagline = try keyedContainer.decode(String.self, forKey: .tagline)
        votesCount = try keyedContainer.decode(Int.self, forKey: .votesCount)
        thumbnail = try keyedContainer.decode(Media.self, forKey: .thumbnail)
        user = try keyedContainer.decode(User.self, forKey: .user)
        description = try? keyedContainer.decode(String.self, forKey: .description)
        makers = try? keyedContainer.decode([User].self, forKey: .makers)
        media = try? keyedContainer.decode([Media].self, forKey: .media)
    }

    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name
        case tagline
        case votesCount
        case thumbnail
        case user
        case description
        case makers
        case media
    }
}

extension Post: Detailable {
    var imagePath: String {
        return thumbnail.url
    }

    var kind: DetailKind {
        return .post
    }
}

extension Post: Equatable {
    static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

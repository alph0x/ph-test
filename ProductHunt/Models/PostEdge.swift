//
//  PostEdge.swift
//  ProductHunt
//
//  Created by Alfredo E. Pérez Leal on 05/10/2021.
//

import Foundation

class PostEdge: Codable {
    var cursor: String
    var node: Post

    required init(from decoder: Decoder) throws {
        let keyedContainer = try decoder.container(keyedBy: CodingKeys.self)
        node = try keyedContainer.decode(Post.self, forKey: .node)
        cursor = try keyedContainer.decode(String.self, forKey: .cursor)
    }

    public enum CodingKeys: String, CodingKey {
        case node
        case cursor
    }
}

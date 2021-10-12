//
//  PostConnection.swift
//  ProductHunt
//
//  Created by Alfredo E. Pérez Leal on 05/10/2021.
//

import Foundation

class PostConnection: Codable {
    var edges: [PostEdge]

    required init(from decoder: Decoder) throws {
        let keyedContainer = try decoder.container(keyedBy: CodingKeys.self)
        edges = try keyedContainer.decode([PostEdge].self, forKey: .edges)
    }

    private enum CodingKeys: String, CodingKey {
        case edges
    }
}

extension Array where Element == PostEdge {

    var lastCursor: String {
        return last?.cursor ?? ""
    }
}

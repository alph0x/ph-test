//
//  Media.swift
//  ProductHunt
//
//  Created by Alfredo E. Pérez Leal on 05/10/2021.
//

import Foundation

class Media: Codable {
    var url: String

    required init(from decoder: Decoder) throws {
        let keyedContainer = try decoder.container(keyedBy: CodingKeys.self)
        url = try keyedContainer.decode(String.self, forKey: .url)
    }

    private enum CodingKeys: String, CodingKey {
        case url
    }
}

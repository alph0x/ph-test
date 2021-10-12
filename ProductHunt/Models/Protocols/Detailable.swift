//
//  Detailable.swift
//  ProductHunt
//
//  Created by Alfredo E. Pérez Leal on 10/10/2021.
//

import Foundation

enum DetailKind {
    case post, user
}

protocol Detailable {
    var kind: DetailKind { get }
    var identifier: String { get }
    var name: String { get }
}

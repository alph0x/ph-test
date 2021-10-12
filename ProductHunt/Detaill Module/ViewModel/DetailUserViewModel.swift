//
//  DetailUserViewModel.swift
//  ProductHunt
//
//  Created by Alfredo E. Pérez Leal on 11/10/2021.
//

import Foundation
import SwiftyUtils

struct DetailUserViewModel {

    static func cells(for user: Detailable, on tableView: UITableView) -> [UITableViewCell] {
        guard let user = user as? User else { return [] }

        let header: UserHeaderTableViewCell = UserHeaderTableViewCell.dequeue(on: tableView)
        header.update(for: user)

        var cells: [UITableViewCell] = [header]
        if let posts = user.votedPosts?.edges,
           posts.isNotEmpty {
            let separator: SeparatorTableViewCell = SeparatorTableViewCell.dequeue(on: tableView)
            separator.update(with: "Voted posts")
            cells.append(separator)
            let postsCells: [PostTableViewCell] = posts.mapToCells(for: tableView)
            cells.append(contentsOf: postsCells)
        }
        return cells
    }
}

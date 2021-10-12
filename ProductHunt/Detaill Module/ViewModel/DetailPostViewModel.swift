//
//  DetailPostViewModel.swift
//  ProductHunt
//
//  Created by Alfredo E. Pérez Leal on 10/10/2021.
//

import UIKit
import SwiftyUtils

struct DetailPostViewModel {

    static func cells(for post: Detailable, on tableView: UITableView) -> [UITableViewCell] {
        guard let post = post as? Post else { return [] }

        let header: PostHeaderTableViewCell = PostHeaderTableViewCell.dequeue(on: tableView)
        header.update(with: post)

        var cells: [UITableViewCell] = [header]

        if let media = post.media,
           media.isNotEmpty {
            let separator: SeparatorTableViewCell = SeparatorTableViewCell.dequeue(on: tableView)
            separator.update(with: "Images")
            let gallery: PostGalleryTableViewCell = PostGalleryTableViewCell.dequeue(on: tableView)
            gallery.update(with: media)
            cells.append(contentsOf: [separator, gallery])
        }

        let hunter: HunterTableViewCell = HunterTableViewCell.dequeue(on: tableView)
        hunter.update(for: post.user)

        let votes: VotesTableViewCell = VotesTableViewCell.dequeue(on: tableView)
        votes.update(with: post.votesCount)

        cells.append(contentsOf: [hunter, votes])

        if let desc = post.description,
           desc.isNotEmpty {
            let description: DescriptionTableViewCell = DescriptionTableViewCell.dequeue(on: tableView)
            description.update(with: desc)
            let separator: SeparatorTableViewCell = SeparatorTableViewCell.dequeue(on: tableView)
            separator.update(with: "Description")
            cells.append(contentsOf: [separator, description])
        }

        if let makers = post.makers,
           makers.isNotEmpty {
            let makersCells: [MakerTableViewCell] = makers.map {
                let maker: MakerTableViewCell = MakerTableViewCell.dequeue(on: tableView)
                maker.update(for: $0)
                return maker
            }

            let separator: SeparatorTableViewCell = SeparatorTableViewCell.dequeue(on: tableView)
            separator.update(with: "Makers")

            cells.append(separator)
            cells.append(contentsOf: makersCells)
        }

        return cells
    }
}

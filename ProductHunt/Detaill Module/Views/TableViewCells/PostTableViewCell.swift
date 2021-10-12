//
//  PostTableViewCell.swift
//  ProductHunt
//
//  Created by Alfredo E. Pérez Leal on 11/10/2021.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    @IBOutlet private weak var postImageView: UIImageView! {
        didSet {
            _ = postImageView.then {
                $0.circular()
            }
        }
    }
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var taglineLabel: UILabel!
    @IBOutlet private weak var userButton: UIButton! {
        didSet {
            userButton.isHiddenWhenSkeletonIsActive = true
        }
    }
    @IBOutlet private weak var votesLabel: UILabel!

    private(set) var post: PostEdge?

    private var components: [UIView] {
        return [postImageView, nameLabel, taglineLabel, userButton, votesLabel]
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        components.forEach {
            $0.showAnimatedGradientSkeleton()
        }
    }

    func hideSkeleton() {
        components.forEach {
            $0.hideSkeleton()
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        post = nil
        postImageView.image = nil
        nameLabel.text = nil
        taglineLabel.text = nil
        userButton.set(nil)
        votesLabel.text = nil
    }

    func update(for edge: PostEdge) {
        post = edge
        hideSkeleton()
        postImageView.setImage(from: edge.node.imagePath)
        nameLabel.text = edge.node.name
        taglineLabel.text = edge.node.tagline
        userButton.set(edge.node.user.username)
        votesLabel.text = "\(edge.node.votesCount)"
    }
}

extension Array where Element == PostEdge {
    func mapToCells(for tableView: UITableView) -> [PostTableViewCell] {
        return map {
            let cell: PostTableViewCell = PostTableViewCell.dequeue(on: tableView)
            cell.update(for: $0)
            return cell
        }
    }
}

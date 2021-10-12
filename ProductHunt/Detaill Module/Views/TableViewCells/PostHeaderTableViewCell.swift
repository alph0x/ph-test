//
//  PostHeaderTableViewCell.swift
//  ProductHunt
//
//  Created by Alfredo E. Pérez Leal on 11/10/2021.
//

import UIKit

class PostHeaderTableViewCell: UITableViewCell {
    @IBOutlet private weak var backgroundImageView: UIImageView!
    @IBOutlet private weak var logoImageView: UIImageView! {
        didSet {
            _ = logoImageView.then {
                $0.circular()
            }
        }
    }
    @IBOutlet private weak var taglineLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        backgroundImageView.image = nil
        logoImageView.image = nil
        taglineLabel.text = nil
    }

    func update(with post: Post) {
        backgroundImageView.setImage(from: post.thumbnail.url)
        logoImageView.setImage(from: post.thumbnail.url)
        taglineLabel.text = post.tagline
    }
}

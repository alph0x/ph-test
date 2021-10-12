//
//  MakerTableViewCell.swift
//  ProductHunt
//
//  Created by Alfredo E. Pérez Leal on 11/10/2021.
//

import UIKit

class MakerTableViewCell: UITableViewCell {
    @IBOutlet private weak var profileImageView: UIImageView! {
        didSet {
            _ = profileImageView.then {
                $0.circular()
            }
        }
    }

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var usernameButton: UIButton!

    private(set) var user: User?

    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        nameLabel.text = nil
        usernameButton.setTitle(nil, for: .normal)
    }

    func update(for maker: User) {
        user = maker
        profileImageView.setImage(from: maker.profileImage)
        nameLabel.text = maker.name
        usernameButton.set(maker.username)
    }
}

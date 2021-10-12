//
//  UserHeaderTableViewCell.swift
//  ProductHunt
//
//  Created by Alfredo E. Pérez Leal on 11/10/2021.
//

import UIKit

class UserHeaderTableViewCell: UITableViewCell {
    @IBOutlet private weak var userImageView: UIImageView! {
        didSet {
            _ = userImageView.then {
                $0.circular()
            }
        }
    }
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var usernameButton: UIButton!

    override func prepareForReuse() {
        super.prepareForReuse()
        userImageView.image = nil
        nameLabel.text = nil
        usernameButton.set(nil)
    }

    func update(for user: User) {
        userImageView.setImage(from: user.profileImage)
        nameLabel.text = user.name
        usernameButton.set(user.username)
    }
}

//
//  HunterTableViewCell.swift
//  ProductHunt
//
//  Created by Alfredo E. Pérez Leal on 11/10/2021.
//

import UIKit

class HunterTableViewCell: UITableViewCell {

    @IBOutlet private weak var usernameButton: UIButton!
    @IBOutlet private weak var nameLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        usernameButton.setTitle(nil, for: .normal)
    }

    func update(for user: User) {
        nameLabel.text = user.name
        usernameButton.set(user.username)
    }
}

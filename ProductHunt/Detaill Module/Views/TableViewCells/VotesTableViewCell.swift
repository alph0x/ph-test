//
//  VotesTableViewCell.swift
//  ProductHunt
//
//  Created by Alfredo E. Pérez Leal on 11/10/2021.
//

import UIKit

class VotesTableViewCell: UITableViewCell {
    @IBOutlet private weak var votesLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        votesLabel.text = nil
    }

    func update(with votes: Int) {
        votesLabel.text = "\(votes)"
    }
}

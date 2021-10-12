//
//  DescriptionTableViewCell.swift
//  ProductHunt
//
//  Created by Alfredo E. Pérez Leal on 11/10/2021.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {

    @IBOutlet private weak var containerLabel: UIView! {
        didSet {
            _ = containerLabel.then {
                $0.set(cornerRadius: 20)
            }
        }
    }
    @IBOutlet private weak var descriptionLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        descriptionLabel.text = nil
    }

    func update(with text: String) {
        descriptionLabel.text = text
    }
}

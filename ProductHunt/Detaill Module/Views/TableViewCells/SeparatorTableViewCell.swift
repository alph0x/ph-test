//
//  SeparatorTableViewCell.swift
//  ProductHunt
//
//  Created by Alfredo E. Pérez Leal on 11/10/2021.
//

import UIKit

class SeparatorTableViewCell: UITableViewCell {

    override func prepareForReuse() {
        super.prepareForReuse()
        textLabel?.text = nil
    }

    func update(with text: String) {
        textLabel?.text = text
    }
}

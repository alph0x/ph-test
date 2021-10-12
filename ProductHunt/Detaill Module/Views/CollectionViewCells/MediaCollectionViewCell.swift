//
//  MediaCollectionViewCell.swift
//  ProductHunt
//
//  Created by Alfredo E. Pérez Leal on 12/10/2021.
//

import UIKit

class MediaCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var imageView: UIImageView!

    override func prepareForReuse() {
        imageView.image = nil
    }

    func update(for media: Media) {
        imageView.setImage(from: media.url)
    }

    class var reuseIdentifier: String {
        return String(describing: self)
    }
}

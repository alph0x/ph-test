//
//  PostGalleryTableViewCell.swift
//  ProductHunt
//
//  Created by Alfredo E. Pérez Leal on 12/10/2021.
//

import UIKit
import SwiftyUtils

class PostGalleryTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionViewCell: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        _ = collectionViewCell.then {
            $0.dataSource = self
            $0.delegate = self
            $0.register(UINib(nibName: MediaCollectionViewCell.reuseIdentifier,
                              bundle: Bundle.main),
                        forCellWithReuseIdentifier: MediaCollectionViewCell.reuseIdentifier)
        }
    }

    private var media: [Media] = [] {
        didSet {
            collectionViewCell.reloadData()
        }
    }

    func update(with media: [Media]) {
        self.media = media
    }
}

extension PostGalleryTableViewCell: UICollectionViewDataSource,
                                    UICollectionViewDelegate,
                                    UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return media.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: MediaCollectionViewCell =
                collectionView.dequeueReusableCell(withReuseIdentifier: MediaCollectionViewCell.reuseIdentifier,
                                                   for: indexPath) as? MediaCollectionViewCell else {
                    fatalError()
                }
        cell.update(for: media[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = UIScreen.width
        let height: CGFloat = width * 0.5625
        return CGSize(width: width, height: height)
    }

}

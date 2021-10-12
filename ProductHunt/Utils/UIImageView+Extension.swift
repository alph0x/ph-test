//
//  UIImageView+Extension.swift
//  ProductHunt
//
//  Created by Alfredo E. Pérez Leal on 11/10/2021.
//

import UIKit
import MapleBacon

extension UIImageView {

    func setImage(from path: String?) {
        setImage(with: URL(string: path ?? ""))
    }
}

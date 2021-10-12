//
//  UIView+Extensions.swift
//  ProductHunt
//
//  Created by Alfredo E. Pérez Leal on 10/10/2021.
//

import UIKit

// swiftlint:disable force_cast
extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }

    func circular() {
        contentMode = .scaleAspectFill
        set(cornerRadius: bounds.width/2)
    }

    func set(cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
    }
}

//
//  UITableViewCell+Extension.swift
//  ProductHunt
//
//  Created by Alfredo E. Pérez Leal on 12/10/2021.
//

import UIKit

extension UITableViewCell {
    class var reuseIdentifier: String {
        return String(describing: self)
    }
}

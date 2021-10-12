//
//  UIButton+Extension.swift
//  ProductHunt
//
//  Created by Alfredo E. Pérez Leal on 11/10/2021.
//

import UIKit

extension UIButton {
    func set(_ username: String?) {
        isUserInteractionEnabled = false
        guard let username = username else {
            setTitle(nil, for: .normal)
            return
        }
        setTitle("@\(username)", for: .normal)
    }
}

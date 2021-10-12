//
//  DetaillViewModel.swift
//  ProductHunt
//
//  Created by Alfredo E. Pérez Leal on 10/10/2021.
//

import Foundation
import UIKit

final class DetailViewModel {

    private(set) var cells: [UITableViewCell] = []

    init(with object: Detailable, on tableView: UITableView) {
        buildUserInterface(for: object, on: tableView)
    }

    func buildUserInterface(for object: Detailable, on tableView: UITableView) {
        switch object.kind {
        case .post:
            cells = DetailPostViewModel.cells(for: object, on: tableView)
        case .user:
            cells = DetailUserViewModel.cells(for: object, on: tableView)
        }
    }
}

extension UITableViewCell {

    class func register(on tableView: UITableView) {
        let identifier = Self.reuseIdentifier
        tableView.register(UINib(nibName: identifier, bundle: Bundle.main),
                           forCellReuseIdentifier: identifier)
    }

    class func dequeue<T: UITableViewCell>(on tableView: UITableView) -> T {
        register(on: tableView)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: self)) as? T else {
            fatalError()
        }
        return cell
    }
}

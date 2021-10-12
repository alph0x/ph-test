//
//  HomePresenter.swift
//  ProductHunt
//
//  Created by Alfredo E. Pérez Leal on 07/10/2021.
//

import Foundation
import UIKit

final class HomePresenter {
    private(set) var viewController: HomeViewController?
    private(set) var cursor: String?

    init(viewController: HomeViewController?) {
        self.viewController = viewController
    }

    func loadingCells(on tableView: UITableView) {
        viewController?.dataSource = [PostTableViewCell.dequeue(on: tableView),
                                      PostTableViewCell.dequeue(on: tableView),
                                      PostTableViewCell.dequeue(on: tableView),
                                      PostTableViewCell.dequeue(on: tableView),
                                      PostTableViewCell.dequeue(on: tableView)]
    }

    func fetched(posts: [PostEdge], for tableView: UITableView, append: Bool) {
        cursor = posts.lastCursor
        let fetchedCells: [PostTableViewCell] = posts.mapToCells(for: tableView)
        if append {
            viewController?.dataSource.append(contentsOf: fetchedCells)
        } else {
            viewController?.dataSource = fetchedCells
        }
        tableView.reloadData()
    }

    func handle(_ error: Error) {
        let alert = UIAlertController(title: error.localizedDescription)
        alert.addAction(UIAlertAction(title: "Accept", style: .cancel, handler: nil))
        viewController?.present(alert, animated: true, completion: nil)
    }
}

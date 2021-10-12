//
//  DetailPresenter.swift
//  ProductHunt
//
//  Created by Alfredo E. Pérez Leal on 07/10/2021.
//

import Foundation
import UIKit

final class DetailPresenter {
    private(set) var viewController: DetailViewController?
    var onFetch: ((Post) -> Void)?

    init(viewController: DetailViewController) {
        self.viewController = viewController
    }

    func build(for object: Detailable, on tableView: UITableView) {
        let viewModel = DetailViewModel(with: object, on: tableView)
        viewController?.updateDataSource(with: viewModel.cells, shouldAppend: false)
    }

    func fetched(posts: [PostEdge], for tableView: UITableView) {
        let fetchedCells: [PostTableViewCell] = posts.mapToCells(for: tableView)
        viewController?.updateDataSource(with: fetchedCells)
    }

    func handle(_ error: Error) {
        let alert = UIAlertController(title: error.localizedDescription)
        alert.addAction(UIAlertAction(title: "Accept", style: .cancel, handler: nil))
        viewController?.present(alert, animated: true, completion: nil)
    }
}

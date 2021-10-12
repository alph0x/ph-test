//
//  HomeInteractor.swift
//  ProductHunt
//
//  Created by Alfredo E. Pérez Leal on 07/10/2021.
//

import Foundation
import UIKit

class HomeInteractor {
    var presenter: HomePresenter?
    var manager: HomeManager?
    var cursor: String? { return presenter?.cursor }
    var loading: Bool = false

    init(presenter: HomePresenter,
         manager: HomeManager) {
        self.presenter = presenter
        self.manager = manager
    }

    func loadingCells(on tableView: UITableView) {
        presenter?.loadingCells(on: tableView)
    }

    func fetch(for tableView: UITableView) {
        guard loading == false else { return }
        loading = true
        manager?.fetchPosts(from: cursor,
                            onCompletion: { [weak self] result in
            guard let self = self else { return }
            self.loading = false
            switch result {
            case .success(let posts):
                guard posts.isNotEmpty else {
                    self.loading = true
                    return
                }
                self.presenter?.fetched(posts: posts, for: tableView, append: self.cursor != nil)
            case .failure(let error):
                self.presenter?.handle(error)
            }
        })
    }
}

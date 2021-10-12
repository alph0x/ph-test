//
//  DetailInteractor.swift
//  ProductHunt
//
//  Created by Alfredo E. Pérez Leal on 07/10/2021.
//

import Foundation
import UIKit

class DetailInteractor {

    private(set) var object: Detailable

    private var cursor: String?
    private var isLoading: Bool = false

    var presenter: DetailPresenter?
    var manager: DetailManager?

    init(object: Detailable,
         presenter: DetailPresenter,
         manager: DetailManager) {
        self.object = object
        self.presenter = presenter
        self.manager = manager
    }

    func build(for tableView: UITableView) {
        presenter?.viewController?.title = object.name
        presenter?.build(for: object, on: tableView)
    }

    func fetch(_ onCompletion: @escaping (() -> Void)) {
        isLoading = true
        switch object.kind {
        case .post:
            manager?.fetchPost(object.identifier, onCompletion: { [weak self] result in
                guard let self = self else { return }
                self.isLoading = false
                switch result {
                case .success(let post):
                        self.object = post
                case .failure(let error):
                    print(error)
                }
                onCompletion()
            })
        case .user:
                manager?.fetchUser(object.identifier, onCompletion: { [weak self] result in
                    guard let self = self else { return }
                    self.isLoading = false
                    switch result {
                    case .success(let user):
                            self.cursor = user.votedPosts?.edges.lastCursor
                            self.object = user
                    case .failure(let error):
                        print(error)
                    }
                    onCompletion()
                })
        }
    }

    func fetchPosts(for tableView: UITableView) {
        guard let user = object as? User,
              isLoading == false else { return }
        isLoading = true
        manager?.fetchPosts(for: object.identifier, after: cursor, onCompletion: { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let fetchedUser):
                guard let votedPosts = fetchedUser.votedPosts,
                      votedPosts.edges.isNotEmpty else {
                          self.isLoading = true
                          return
                      }
                self.cursor = votedPosts.edges.lastCursor
                user.votedPosts?.edges.append(contentsOf: votedPosts.edges)
            case .failure(let error):
                self.presenter?.handle(error)
            }
        })
    }
}

//
//  HomeViewController.swift
//  ProductHunt
//
//  Created by Alfredo E. Pérez Leal on 07/10/2021.
//

import UIKit
import SkeletonView
import Haptica

private extension String {
    static var postCollectionCell: String = "PostCollectionViewCell"
}

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            _ = tableView.then {
                $0.dataSource = self
                $0.delegate = self
            }
        }
    }

    var interactor: HomeInteractor?
    var router: HomeRouter?
    var dataSource: [PostTableViewCell] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ProductHunt"
        interactor?.loadingCells(on: tableView)
        interactor?.fetch(for: tableView)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return dataSource[indexPath.row]
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath) as? PostTableViewCell,
              let post = cell.post else { return }
        Haptic.impact(.medium).generate()
        router?.open(post.node)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height {
            interactor?.fetch(for: tableView)
        }
    }
}

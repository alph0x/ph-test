//
//  DetailViewController.swift
//  ProductHunt
//
//  Created by Alfredo E. Pérez Leal on 07/10/2021.
//

import UIKit
import Haptica

class DetailViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            _ = tableView.then {
                $0.dataSource = self
                $0.delegate = self
            }
        }
    }
    private(set) var dataSource: [UITableViewCell] = []

    var interactor: DetailInteractor?
    var router: DetailRouter?

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.build(for: tableView)
        interactor?.fetch { [weak self] in
            guard let self = self else { return }
            self.interactor?.build(for: self.tableView)
        }
    }

    func updateDataSource(with cells: [UITableViewCell], shouldAppend: Bool = true) {
        if shouldAppend {
            dataSource.append(contentsOf: cells)
        } else {
            dataSource = cells
        }
        tableView.reloadData()
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return dataSource[indexPath.row]
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        Haptic.impact(.medium).generate()
        if let cell = tableView.cellForRow(at: indexPath) as? MakerTableViewCell,
           let user = cell.user {
            router?.open(user)
        }
        if let cell = tableView.cellForRow(at: indexPath) as? PostTableViewCell,
           let post = cell.post {
            router?.open(post.node)
        }
    }

    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        if tableView.cellForRow(at: indexPath) is MakerTableViewCell ||
            tableView.cellForRow(at: indexPath) is PostTableViewCell {
            return true
        }
        return false
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height {
            interactor?.fetchPosts(for: tableView)
        }
    }
}

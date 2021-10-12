//
//  DetailRouter.swift
//  ProductHunt
//
//  Created by Alfredo E. Pérez Leal on 07/10/2021.
//

import Foundation

final class DetailRouter {
    weak var viewController: DetailViewController?

    init(viewController: DetailViewController) {
        self.viewController = viewController
    }

    func open(_ post: Post) {
        let detail = DetailModuleConfigurator.build(for: post)
        viewController?.navigationController?.pushViewController(detail, animated: true)
    }

    func open(_ user: User) {
        let detail = DetailModuleConfigurator.build(for: user)
        viewController?.navigationController?.pushViewController(detail, animated: true)
    }
}

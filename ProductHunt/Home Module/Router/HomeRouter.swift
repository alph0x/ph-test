//
//  HomeRouter.swift
//  ProductHunt
//
//  Created by Alfredo E. Pérez Leal on 07/10/2021.
//

import Foundation

class HomeRouter {
    weak var viewController: HomeViewController?

    init(viewController: HomeViewController) {
        self.viewController = viewController
    }

    func open(_ post: Post) {
        let detail = DetailModuleConfigurator.build(for: post)
        viewController?.navigationController?.pushViewController(detail, animated: true)
    }
}

//
//  HomeModuleConfigurator.swift
//  ProductHunt
//
//  Created by Alfredo E. Pérez Leal on 07/10/2021.
//

import Foundation

class HomeModuleConfigurator {

    static func build() -> HomeViewController {
        let controller = HomeViewController()
        let manager = HomeManager()
        let router = HomeRouter(viewController: controller)
        let presenter = HomePresenter(viewController: controller)
        let interactor = HomeInteractor(presenter: presenter,
                                        manager: manager)
        controller.interactor = interactor
        controller.router = router

        return controller
    }
}

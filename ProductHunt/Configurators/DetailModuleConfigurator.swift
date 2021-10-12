//
//  DetailModuleConfigurator.swift
//  ProductHunt
//
//  Created by Alfredo E. Pérez Leal on 07/10/2021.
//

import Foundation

class DetailModuleConfigurator {

    static func build(for object: Detailable) -> DetailViewController {
        let controller = DetailViewController()
        let manager = DetailManager()
        let router = DetailRouter(viewController: controller)
        let presenter = DetailPresenter(viewController: controller)
        let interactor = DetailInteractor(object: object,
                                          presenter: presenter,
                                          manager: manager)
        controller.interactor = interactor
        controller.router = router

        return controller
    }
}

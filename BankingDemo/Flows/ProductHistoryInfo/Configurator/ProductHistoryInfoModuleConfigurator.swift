//
//  ProductHistoryInfoModuleConfigurator.swift
//  ZenitOnline
//

import UIKit

final class ProductHistoryInfoModuleConfigurator {

    // MARK: - Internal Methods

    func configure(output: ProductHistoryInfoOutput, rootRouter: ModuleTransitionable) -> (ContentCollaborative, ProductHistoryInfoInput) {
        let view = ContentCollaborativeViewController()
        let presenter = ProductHistoryInfoPresenter(service: HistoryMockService())
        let router = ProductHistoryInfoRouter()

        router.view = rootRouter

        presenter.view = view
        presenter.output = output
        presenter.router = router

        view.output = presenter

        return (view, presenter)
    }

}

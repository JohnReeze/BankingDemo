//
//  ProductMainInfoConfigurator.swift
//  BankingDemo
//

import UIKit

final class ProductMainInfoModuleConfigurator {

    // MARK: - Internal methods

    func configure(rootView: ModuleTransitionable, output: ProductMainInfoOutput) -> (view: ContentScrollableHeader, input: ProductMainInfoInput) {
        let view = ProductMainInfoViewController()
        let presenter = ProductMainInfoPresenter()
        let router = ProductMainInfoRouter()

        presenter.view = view
        presenter.router = router
        presenter.output = output
        router.view = rootView
        view.output = presenter

        return (view, presenter)
    }

}

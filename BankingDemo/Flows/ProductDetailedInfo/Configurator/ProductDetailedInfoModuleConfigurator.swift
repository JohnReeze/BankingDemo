//
//  ProductDetailedInfoModuleConfigurator.swift
//  BankingDemo
//

import UIKit

final class ProductDetailedInfoModuleConfigurator {

    // MARK: - Internal methods

    func configure(rootView: ModuleTransitionable, output: ProductDetailedInfoOutput) -> (view: ProductDetailedInfoViewProtocol, input: ProductDetailedInfoInput) {
        let view = ProductDetailedInfoViewController()
        let presenter = ProductDetailedInfoPresenter()
        let router = ProductDetailedInfoRouter()

        let (historyView, historyInput) = ProductHistoryInfoModuleConfigurator().configure(output: presenter, rootRouter: rootView)

        presenter.view = view
        presenter.router = router
        presenter.output = output
        presenter.historyInput = historyInput

        view.output = presenter
        view.historyContent = historyView

        router.view = rootView

        return (view, presenter)
    }

}

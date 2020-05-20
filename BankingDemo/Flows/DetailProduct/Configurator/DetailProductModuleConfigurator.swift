//
//  DetailProductModuleConfigurator.swift
//  BankingDemo
//

import UIKit

final class DetailProductModuleConfigurator {

    // MARK: - Internal methods

    func configure() -> UIViewController {
        let view = DetailProductViewController()

        let presenter = DetailProductPresenter(productService: ProdcutMockService())
        let router = DetailProductRouter()

        let (headerView, headerInput) = ProductMainInfoModuleConfigurator().configure(rootView: view, output: presenter)

        let (detailedView, detailedInput) = ProductDetailedInfoModuleConfigurator().configure(rootView: view, output: presenter)

        presenter.mainContentInput = headerInput
        presenter.detailedContentInput = detailedInput
        presenter.view = view
        presenter.router = router

        view.headerContent = headerView
        view.mainContent = detailedView
        view.output = presenter

        router.view = view

        return view
    }

}

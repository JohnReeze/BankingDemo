//
//  DetailProductModuleConfigurator.swift
//  BankingDemo
//

import UIKit

final class DetailProductModuleConfigurator {

    // MARK: - Internal methods

    func configure() -> UIViewController {
        let view = DetailProductViewController()

        let presenter = DetailProductPresenter()
        let router = DetailProductRouter()

        presenter.view = view
        presenter.router = router
        view.output = presenter
        router.view = view

        return view
    }

}

//
//  DetailProductPresenter.swift
//  BankingDemo
//

struct DetailProductNameModel {
    let title: String
    let subTitle: String?
}

final class DetailProductPresenter {

    // MARK: - Typealias

    typealias DetailProductModel = (id: String, type: FinanceProductType)

    // MARK: - Properties

    weak var view: DetailProductViewInput?
    var router: DetailProductRouterInput?

    // MARK: - Private Properties

    // MARK: - Initialization

    init() {

    }

}

// MARK: - DetailProductViewOutput

extension DetailProductPresenter: DetailProductViewOutput {

    func viewLoaded() {
        view?.setupInitialState()
    }

    func closeAction() {

    }

    func updateAction() {

    }

    func viewDidAppear() {

    }

    func viewWillDisappear() {

    }

}

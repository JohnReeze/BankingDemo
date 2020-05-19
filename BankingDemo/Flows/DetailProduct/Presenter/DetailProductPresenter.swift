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
    weak var mainContentInput: ProductMainInfoInput?
    weak var detailedContentInput: ProductDetailedInfoInput?
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
        detailedContentInput?.configure(with: [
            "TestID1",
            "TestID2",
            "TestID3",
            "TestID4"
        ], selectedIndex: 0)

        view?.configure(with: .init(title: "Счет Tinkoff Black", subTitle: "128 204,19 ₽"))
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

extension DetailProductPresenter: ProductMainInfoOutput {
    func didStateChanged(_ newState: ProductStateViewModel) {

    }

    func didSelectCard(at index: Int?) {

    }

    func didChangedBalance(_ isHidden: Bool) {

    }

}

extension DetailProductPresenter: ProductDetailedInfoOutput {

}

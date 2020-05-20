//
//  ProductMainInfoPresenter.swift
//  BankingDemo
//

final class ProductMainInfoPresenter {

    // MARK: - Properties

    weak var view: ProductMainInfoViewInput?
    var router: ProductMainInfoRouterInput?
    weak var output: ProductMainInfoOutput?

    // MARK: - Private Properties
}

// MARK: - ProductInfoContainerViewOutput

extension ProductMainInfoPresenter: ProductMainInfoViewOutput {

    func viewLoaded() {
        view?.setupInitialState()
    }

    func didSelectAction(_ action: ProductFastActionType) {
    }

    func didStateChanged(_ newState: ProductStateViewModel) {
        output?.didStateChanged(newState)
    }

    func didSelectHideOption() {

    }

}

// MARK: - ProductMainInfoInput

extension ProductMainInfoPresenter: ProductMainInfoInput {

    func configure(with models: [ProductViewModel]) {
        view?.configure(with: models)
    }
}

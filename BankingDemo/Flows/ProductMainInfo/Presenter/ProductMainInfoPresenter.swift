//
//  ProductMainInfoPresenter.swift
//  ZenitOnline
//
//  Created by Mikhail Monakov on 27/01/2020.
//  Copyright © 2020 Surf. All rights reserved.
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

    func didSelectCard(at index: Int?) {
        output?.didSelectCard(at: index)
    }

    func didStateChanged(_ newState: ProductStateViewModel) {
        output?.didStateChanged(newState)
    }

    func didSelectHideOption() {

    }

}

// MARK: - ProductMainInfoInput

extension ProductMainInfoPresenter: ProductMainInfoInput {

}

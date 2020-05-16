//
//  ProductHistoryInfoPresenter.swift
//  ZenitOnline
//

final class ProductHistoryInfoPresenter: ProductHistoryInfoInput {

    // MARK: - Properties

    weak var view: ContentCollaborativeViewInput?
    weak var output: ProductHistoryInfoOutput?
    var router: ProductHistoryInfoRouterInput?

    // MARK: - Private Properties

    private let viewModel = ProductHistoryInfoViewModel()
    private var viewIsReady = false

    func forceUpdate() {
        
    }
}

// MARK: - ProductHistoryInfoViewOutput

extension ProductHistoryInfoPresenter: ContentCollaborativeViewOutput {

    func viewLoaded() {
        view?.setupInitialState()
        view?.configure(viewModel: viewModel)
        viewIsReady = true
    }

}

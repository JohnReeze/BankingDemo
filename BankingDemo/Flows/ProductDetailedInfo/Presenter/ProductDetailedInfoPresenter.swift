//
//  ProductDetailedInfoPresenter.swift
//  BankingDemo
//

final class ProductDetailedInfoPresenter {

    // MARK: - Constants

    private enum Constants {
        static let halfProgress = 0.5
    }

    // MARK: - Properties

    weak var view: ProductDetailedInfoViewInput?
    var router: ProductDetailedInfoRouterInput?
    weak var output: ProductDetailedInfoOutput?
    weak var historyInput: ProductHistoryInfoInput?

    // MARK: - Private Properties

    private var currentState: DetailProductState = 0
    private var nextState: DetailProductState = 0
    private var models: [ProductViewModel] = []
    private var currentTabIndex = 0

}

// MARK: - ProductDetailedInfoInput

extension ProductDetailedInfoPresenter: ProductDetailedInfoInput {

    func configure(with models: [ProductViewModel]) {
        self.models = models
        self.currentState = 0
        self.nextState = 0
        updateStates(for: 0)
        models.first?.id ~> historyInput?.update
    }

    func didChangedState(_ newState: ProductStateViewModel) {
        view?.setStateChangeProgress(newState.progress)
        currentState = newState.fromPage

        if newState.progress > Constants.halfProgress {
            guard newState.toPage != nextState else { return }
            nextState = newState.toPage
        } else if nextState != currentState {
            nextState = newState.fromPage
        }
    }

    func forceUpdate() {
//        historyInput?.forceUpdate()
//        additionalInfoInput?.forceUpdate()
    }

}

// MARK: - ProductDetailedInfoViewOutput

extension ProductDetailedInfoPresenter: ProductDetailedInfoViewOutput {

    func viewLoaded() {
        view?.setupInitialState()
    }

    func didChangeState(newState: Int) {
        self.currentTabIndex = newState
    }

}

// MARK: - Private Methods

private extension ProductDetailedInfoPresenter {

    func updateStates(for newIndex: Int) {
    }

}

extension ProductDetailedInfoPresenter: ProductHistoryInfoOutput {

    func didUpdate(model: ExpensesModel) {
        view?.configure(model: model)
    }

}

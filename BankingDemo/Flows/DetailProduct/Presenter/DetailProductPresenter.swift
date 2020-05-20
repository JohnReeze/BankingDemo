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

    private let productService: ProductService
    private var titleModels = [DetailProductNameModel]()
    private var currentState = 0

    // MARK: - Initialization

    init(productService: ProductService) {
        self.productService = productService
    }

}

// MARK: - DetailProductViewOutput

extension DetailProductPresenter: DetailProductViewOutput {

    func viewLoaded() {
        view?.setupInitialState()
        productService.loadProducts { [weak self] result in
            switch result {
            case .success(let models):
                mainContentInput?.configure(with: models)
                detailedContentInput?.configure(with: models)
                self?.titleModels = models.map { .init(title: $0.name, subTitle: $0.type != .linkedCard ? $0.balance : nil) }
                self?.titleModels.first ~> self?.view?.configure
            case .failure(let error):
                dump(error)
            }
        }
    }

    func closeAction() {

    }

    func updateAction() {

    }

}

extension DetailProductPresenter: ProductMainInfoOutput {

    func didStateChanged(_ newState: ProductStateViewModel) {
        detailedContentInput?.didChangedState(newState)
        guard currentState != newState.fromPage else { return }
        currentState = newState.fromPage
        titleModels[safe: currentState] ~> view?.configure
    }

}

extension DetailProductPresenter: ProductDetailedInfoOutput {

}

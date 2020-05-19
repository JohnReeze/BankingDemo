//
//  ProductHistoryInfoPresenter.swift
//  ZenitOnline
//

final class ProductHistoryInfoPresenter {

    // MARK: - Properties

    weak var view: ContentCollaborativeViewInput?
    weak var output: ProductHistoryInfoOutput?
    var router: ProductHistoryInfoRouterInput?

    // MARK: - Private Properties

    private let viewModel = ProductHistoryInfoViewModel()
    private var viewIsReady = false
    private let historyService: HistoryService

    // MARK: - Initialization

    init(service: HistoryService) {
        self.historyService = service
    }

}

// MARK: - ProductHistoryInfoInput

extension ProductHistoryInfoPresenter: ProductHistoryInfoInput {

    func forceUpdate() {

    }

    func update(for productId: String) {
        loadHistory(productId: productId)
    }

}

// MARK: - ProductHistoryInfoViewOutput

extension ProductHistoryInfoPresenter: ContentCollaborativeViewOutput {

    func viewLoaded() {
        view?.setupInitialState()
        view?.configure(viewModel: viewModel)
        viewIsReady = true
        loadHistory(productId: "123")
    }

}

// MARK: - Private Methods

private extension ProductHistoryInfoPresenter {

    func loadHistory(productId: String) {
        viewModel.setState(.loading)
        historyService.loadHistory(productId: productId, offset: 0, limit: 100) { [weak self] (result) in
            switch result {
            case .success(let entity):
                let parser = HistoryModelsParser()
                self?.viewModel.setState(.normal(parser.sortAndParseData(entity)))
            case .failure:
                self?.viewModel.setState(.error)
            }
        }
    }

}

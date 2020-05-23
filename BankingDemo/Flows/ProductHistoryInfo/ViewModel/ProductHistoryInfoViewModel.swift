//
//  ProductHistoryInfoViewModel.swift
//
//

import UIKit

private enum CellTypes {
    case loadingHeader
    case loadingHistory
    case header(String)
    case history(HistoryCellModel)

    var identifier: String {
        switch self {
        case .loadingHeader:
            return HistoryLoaderHeader.nameOfClass
        case .loadingHistory:
            return HistoryLoaderCell.nameOfClass
        case .header:
            return HistoryHeaderCell.nameOfClass
        case .history:
            return HistoryCell.nameOfClass
        }
    }
}

enum ProductHistoryState {
    case loading
    case error
    case normal([HistorySection])
}

final class ProductHistoryInfoViewModel: NSObject, TableViewModel {

    // MARK: - Constants

    private enum Constants {
        static let bottomInset: CGFloat = 40
    }

    // MARK: - Private Properties

    private var cellsToDisplay = [CellTypes]()
    private var tableView: UITableView?
    private lazy var loadingStateCells: [CellTypes] = {
        return [.loadingHeader] + Array(repeating: .loadingHistory, count: 8)
    }()
    private var state = ProductHistoryState.loading

    // MARK: - TableViewModel

    func configure(_ tableView: UITableView) {
        self.tableView = tableView
        configureTableView()
    }

    // MARK: - Internal methods

    func setState(_ state: ProductHistoryState) {
        self.state = state
        switch state {
        case .error, .loading:
            cellsToDisplay = loadingStateCells
        case .normal(let models):
            cellsToDisplay.removeAll()
            cellsToDisplay = models.flatMap {
                [CellTypes.header($0.title)] + $0.items.map { CellTypes.history($0) }
            }
        }
        tableView?.reloadData()
    }

    private func configureTableView() {
        tableView?.dataSource = self
        tableView?.rowHeight = UITableView.automaticDimension
        tableView?.register(HistoryHeaderCell.self, forCellReuseIdentifier: HistoryHeaderCell.nameOfClass)
        tableView?.register(HistoryLoaderHeader.self, forCellReuseIdentifier: HistoryLoaderHeader.nameOfClass)
        [HistoryLoaderCell.self, HistoryCell.self].forEach {
            tableView?.registerNib($0)
        }
        tableView?.contentInset.bottom = Constants.bottomInset
    }

}

extension ProductHistoryInfoViewModel: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellsToDisplay.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = cellsToDisplay[indexPath.row]
        switch type {
        case .loadingHeader, .loadingHistory:
            return getLoaderCell(for: type.identifier)
        case .header(let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: type.identifier) as? HistoryHeaderCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
        case .history(let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: type.identifier) as? HistoryCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
        }
    }

    private func getLoaderCell(for identifier: String) -> UITableViewCell {
        guard let cell = tableView?.dequeueReusableCell(withIdentifier: identifier) as? (UITableViewCell & LoadableView) else {
            return UITableViewCell()
        }
        cell.showLoading(true)
        return cell
    }

}

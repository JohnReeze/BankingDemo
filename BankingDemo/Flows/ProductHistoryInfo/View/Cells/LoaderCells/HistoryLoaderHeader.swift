//
//  HistoryLoaderHeader.swift
//  BankingDemo
//

import UIKit

final class HistoryLoaderHeader: UITableViewCell, LoadableView {

    // MARK: - LoadableView

    var loadingViews: [UIView] {
        return [loadView]
    }

    // MARK: - Private Properties

    private let loadView = UIView()

    // MARK: - UITableViewCell

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupInitialState()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupInitialState()
    }

    override func prepareForReuse() {
        showLoading(false)
    }

    // MARK: - Private methods

    private func setupInitialState() {
        selectionStyle = .none
        addSubview(loadView)

        loadView.anchor(top: self.topAnchor,
                        leading: self.leadingAnchor,
                        bottom: self.bottomAnchor,
                        padding: .init(top: 16, left: 20, bottom: 20, right: 0),
                        size: .init(width: 80, height: 25))
        loadView.clipsToBounds = true
        loadView.layer.cornerRadius = 4
        loadView.backgroundColor = Styles.Colors.placeholderColor.color
        self.backgroundColor = Styles.Colors.main.color
    }

}

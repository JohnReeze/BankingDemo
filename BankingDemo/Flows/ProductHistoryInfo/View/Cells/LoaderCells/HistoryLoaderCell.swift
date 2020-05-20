//
//  HistoryLoaderCell.swift
//  BankingDemo
//

import UIKit

final class HistoryLoaderCell: UITableViewCell, LoadableView {

    // MARK: - LoadableView

    var loadingViews: [UIView] {
        return loadViews
    }

    // MARK: - IBOutlets

    @IBOutlet private weak var loadingCircleView: UIView!
    @IBOutlet private var loadViews: [UIView]!

    // MARK: - UITableViewCell

    override func awakeFromNib() {
        super.awakeFromNib()
        setupInitialState()
    }

    override func prepareForReuse() {
        showLoading(false)
    }

    private func setupInitialState() {
        selectionStyle = .none
        loadViews.forEach {
            $0.backgroundColor = Styles.Colors.placeholderColor.color
            $0.layer.cornerRadius = 4
            $0.clipsToBounds = true
        }
        loadingCircleView.layer.cornerRadius = loadingCircleView.frame.height / 2
        self.backgroundColor = Styles.Colors.main.color
    }

}

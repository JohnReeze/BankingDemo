//
//  HistoryHeaderCell.swift
//  BankingDemo
//

import UIKit

final class HistoryHeaderCell: UITableViewCell {

    private let titleLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupInitialState()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupInitialState()
    }

    func configure(with model: String) {
        titleLabel.text = model
    }

}

private extension HistoryHeaderCell {

    func setupInitialState() {
        selectionStyle = .none
        addSubview(titleLabel)
        titleLabel.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        titleLabel.anchor(top: self.topAnchor,
                          leading: self.leadingAnchor,
                          bottom: self.bottomAnchor,
                          trailing: self.trailingAnchor,
                          padding: .init(top: 16, left: 20, bottom: 20, right: 20))
        self.backgroundColor = Styles.Colors.main.color
    }

}

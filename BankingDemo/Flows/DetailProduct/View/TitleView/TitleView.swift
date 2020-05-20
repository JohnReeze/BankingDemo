//
//  TitleView.swift
//  BankingDemo
//

import UIKit

final class TitleView: UIView {

    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialState()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func configure(title: String, subTitle: String?) {
        titleLabel.text = title
        subTitleLabel.text = subTitle
        titleLabel.font = .systemFont(ofSize: subTitle.isNil ? 17 : 13, weight: subTitle.isNil ? .semibold : .regular)
    }

    private func setupInitialState() {
        subTitleLabel.font = FontFamily.SFProRounded.bold.font(size: 14)
        titleLabel.textAlignment = .center
        subTitleLabel.textAlignment = .center
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        titleLabel.anchor(top: self.topAnchor,
                          leading: self.leadingAnchor,
                          bottom: nil,
                          trailing: self.trailingAnchor)
        subTitleLabel.anchor(top: nil,
                             leading: self.leadingAnchor,
                             bottom: self.bottomAnchor,
                             trailing: self.trailingAnchor)
        let spacingConstraint = titleLabel.bottomAnchor.constraint(equalTo: subTitleLabel.topAnchor, constant: -2)
        spacingConstraint.isActive = true
    }

}

//
//  DetailedProductView.swift
//  BankingDemo
//

import UIKit

final class DetailedProductView: UIView {

    // MARK: - Private Properties

    private let stackView = UIStackView()
    private let mainContainer = UIView()
    private let additionalContainer = UIView()

    override func awakeFromNib() {
        super.awakeFromNib()
        setupInitialState()
    }

    func setMainView(_ view: UIView) {
        mainContainer.subviews.forEach { $0.removeFromSuperview() }
        mainContainer.addSubview(view)
        view.fillSuperview()
    }

    func setAdditionalView(_ view: UIView) {
        additionalContainer.subviews.forEach { $0.removeFromSuperview() }
        additionalContainer.addSubview(view)
        view.fillSuperview()
    }

    private func setupInitialState() {
        self.addSubview(stackView)
        stackView.addArrangedSubview(mainContainer)
        stackView.addArrangedSubview(additionalContainer)
        stackView.spacing = 16
        stackView.alignment = .leading
        stackView.anchor(top: self.topAnchor,
                         leading: self.leadingAnchor,
                         bottom: self.bottomAnchor,
                         trailing: nil)
    }

}

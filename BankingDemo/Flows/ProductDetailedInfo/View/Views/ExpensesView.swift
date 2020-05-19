//
//  ExpensesView.swift
//  BankingDemo
//

import UIKit

extension ExpenseType {

    var color: UIColor {
        switch self {
        case .cash:
            return Styles.Colors.Categories.cash.color
        case .supermarket:
            return Styles.Colors.Categories.supermarkets.color
        case .fastfood:
            return Styles.Colors.Categories.fastfood.color
        case .chemistry:
            return Styles.Colors.Categories.checmistry.color
        case .other:
            return Styles.Colors.Categories.other.color
        }
    }

}

final class ExpensesView: DesignableView {

    // MARK: - IBOutlets

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var sumButton: UIButton!
    @IBOutlet private weak var expensesStackView: UIStackView!
    @IBOutlet private weak var stackViewContainer: UIView!

    // MARK: - Private Properties

    private var expensesConstraints: [ExpenseType: NSLayoutConstraint] = [:]

    // MARK: - UIView

    override func awakeFromNib() {
        super.awakeFromNib()
        setupInitialState()
    }

    func configure(title: String, sum: String, expensesInfo: [(type: ExpenseType, part: Double)]) {
        titleLabel.text = title
        sumButton.setTitle(sum, for: .normal)
        expensesInfo.forEach {
            expensesConstraints[$0.type]?.constant = CGFloat($0.part) * self.frame.width
        }
        expensesStackView.arrangedSubviews.forEach { $0.alpha = 1 }
    }

    private func setupInitialState() {
        view.backgroundColor = Styles.Colors.main.color
        stackViewContainer.layer.cornerRadius = stackViewContainer.frame.height / 2
        stackViewContainer.clipsToBounds = true
        stackViewContainer.backgroundColor = Styles.Colors.placeholderColor.color

        ExpenseType.allCases.forEach {
            let view = UIView()
            view.backgroundColor = $0.color
            view.alpha = 0
            expensesStackView.addArrangedSubview(view)
            let widthConstraint = view.widthAnchor.constraint(equalToConstant: 0)
            widthConstraint.priority = .defaultHigh
            NSLayoutConstraint.activate([widthConstraint])
            expensesConstraints[$0] = widthConstraint
        }
    }

}

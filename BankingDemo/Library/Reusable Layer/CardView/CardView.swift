//
//  CardView.swift
//  BankingDemo

import UIKit

struct CardViewModel {
    let number: String
    let color: UIColor
    let logo: UIImage?
    let typeIcon: UIImage
}

final class CardView: DesignableView {

    // MARK: - IBOutlets

    @IBOutlet private weak var backView: UIView!
    @IBOutlet private weak var bankLogoImageView: UIImageView!
    @IBOutlet private weak var numberLabel: UILabel!
    @IBOutlet private weak var cardTypeImageView: UIImageView!

    // MARK: - UIView

    override func awakeFromNib() {
        super.awakeFromNib()
        setupInitialState()
    }

    // MARK: - Internal methods

    func configure(with model: CardViewModel) {
        backView.backgroundColor = model.color
        numberLabel.text = model.number
        cardTypeImageView.image = model.typeIcon
        bankLogoImageView.image = model.logo
    }

}

// MARK: - Private Methods

private extension CardView {

    func setupInitialState() {
        view.backgroundColor = .clear
        backView.layer.cornerRadius = 4
        numberLabel.font = UIFont.systemFont(ofSize: 10, weight: .bold)
    }

}

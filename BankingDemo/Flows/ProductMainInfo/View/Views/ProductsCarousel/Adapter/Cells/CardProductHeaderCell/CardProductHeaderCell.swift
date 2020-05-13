//
//  CardProductHeaderCell.swift
//  ZenitOnline
//

import UIKit

final class CardProductHeaderCell: UICollectionViewCell {

    // MARK: - IBOutlets

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var cardView: CardView!
    @IBOutlet private weak var settingsButton: UIButton!

    // MARK: - Internal methods

    func configure(title: String, cardModel: CardViewModel) {
        titleLabel.text = title
        cardView.configure(with: cardModel)
    }

}

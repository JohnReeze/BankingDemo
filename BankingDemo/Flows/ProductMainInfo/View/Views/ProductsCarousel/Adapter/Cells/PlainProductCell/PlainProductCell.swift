//
//  PlainProductCell.swift
//  ZenitOnline
//

import UIKit

final class PlainProductCell: UICollectionViewCell {

    // MARK: - IBActions

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var balanceLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var settingsButton: UIButton!

    // MARK: - UICollectionViewCell

    override func awakeFromNib() {
        super.awakeFromNib()
        setupInitialState()
    }

    // MARK: - Private methods

    private func setupInitialState() {
        descriptionLabel.numberOfLines = 0
        balanceLabel.font = FontFamily.SFProRounded.bold.font(size: 40)
    }

}

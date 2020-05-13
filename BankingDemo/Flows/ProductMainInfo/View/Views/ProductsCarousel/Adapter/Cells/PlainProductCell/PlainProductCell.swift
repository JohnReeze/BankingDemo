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
        balanceLabel.font = FontFamily.FranxurterTotally.medium.font(size: 50)
        balanceLabel.addCharacterSpacing(kernValue: 3)
    }

}

// TODO: remove/replace test code
extension UILabel {
  func addCharacterSpacing(kernValue: Double = 1.15) {
    if let labelText = text, !labelText.isEmpty {
      let attributedString = NSMutableAttributedString(string: labelText)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: kernValue, range: NSRange(location: 0, length: attributedString.length - 1))
      attributedText = attributedString
    }
  }
}

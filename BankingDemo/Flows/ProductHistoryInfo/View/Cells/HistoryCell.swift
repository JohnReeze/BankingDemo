//
//  HistoryCell.swift
//  BankingDemo
//

import UIKit
import Nuke

struct HistoryCellModel {
    let placeholder: UIImage
    let iconUrl: String?
    let mainTitle: String
    let subTitle: String?
    let sumString: String
    let category: String?
}

final class HistoryCell: UITableViewCell {

    // MARK: - IBOutlets

    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var mainTitleLabel: UILabel!
    @IBOutlet private weak var subTitleLabel: UILabel!
    @IBOutlet private weak var sumLabel: UILabel!
    @IBOutlet private weak var categoryLabel: UILabel!

    // MARK: - UITableViewCell

    override func awakeFromNib() {
        super.awakeFromNib()
        setupInitialState()
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        UIView.animate(withDuration: Durations.animation) {
            self.contentView.backgroundColor = highlighted ? Styles.Colors.placeholderColor.color : Styles.Colors.main.color
        }
    }

    // MARK: - Internal methods

    func configure(with model: HistoryCellModel) {
        self.iconImageView.image = model.placeholder
        (model.iconUrl ~> URL.init) ~> {
            print($0.absoluteString)
            Nuke.loadImage(with: $0, into: iconImageView)
        }
        self.mainTitleLabel.text = model.mainTitle
        self.subTitleLabel.text = model.subTitle
        self.sumLabel.text = model.sumString
        self.categoryLabel.text = model.category
    }

}

private extension HistoryCell {

    func setupInitialState() {
        selectionStyle = .none
        iconImageView.layer.cornerRadius = iconImageView.frame.height / 2
        iconImageView.clipsToBounds = true
    }

}

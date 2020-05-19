//
//  AddProductView.swift
//  BankingDemo
//

import UIKit

final class AddProductView: UIView {

    // MARK: - Private Properties

    private let addImageView = UIImageView()

    // MARK: - UIView

    override func awakeFromNib() {
        super.awakeFromNib()
        setupInitialState()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialState()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupInitialState()
    }

    // MARK: - Private methods

    private func setupInitialState() {
        self.addSubview(addImageView)
        addImageView.image = Styles.Images.addCard.image
        addImageView.fillSuperview()
        self.layer.cornerRadius = 4
        self.backgroundColor = Styles.Colors.addCardBackround.color
    }

}

//
//  ProductOptionView.swift
//  ZenitOnline
//

import UIKit

enum ProductFastActionType: Int {
    case requisites
    case replenish
    case pay
    case replenishFromCard
    case payByCard
}

final class ProductOptionView: DesignableView {

    // MARK: - Constants

    private enum Constants {
        static let stackViewSpacing: CGFloat = 16
        static let actionsInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        static let actionHeight: CGFloat = 40
        static let minViewHeight: CGFloat = 40
        static let cardTutorialInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }

    // MARK: - Nested types

    private struct ContentInfo {
        let view: UIView
        let topConstraint: NSLayoutConstraint
        let lastOffset: CGFloat
        let defaultBottomOffset: CGFloat

        init(view: UIView,
             topConstraint: NSLayoutConstraint,
             lastOffset: CGFloat = 0,
             defaultBottomOffset: CGFloat = 0) {
            self.view = view
            self.topConstraint = topConstraint
            self.lastOffset = lastOffset
            self.defaultBottomOffset = defaultBottomOffset
        }

    }

    // MARK: - IBOutlets

    // MARK: - Constraints

    // MARK: - Properties

    var didSelectAction: Closure<ProductFastActionType>?
    var didSelectCard: Closure<Int?>?

    // MARK: - Private Properties

    private var reusableButtons = [ProductFastActionType: UIButton]()
    private var topOffset: CGFloat = 0
    private var model: ProductOptionsViewModel?

    private lazy var contentOffsets: [ContentInfo] = {
        return [

        ]
    }()

    // MARK: - UIView

    override func awakeFromNib() {
        super.awakeFromNib()
        setupInitialState()
    }

    // MARK: - Initialization

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupInitialState()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialState()
    }

    // MARK: - Internal Methodss

    func configure(with model: ProductOptionsViewModel) {
        self.topOffset = model.topOffset
        self.model = model
    }

    func updateTopOffset(_ newTopOffset: CGFloat) {
        self.topOffset = newTopOffset

    }

    func update(with newModel: ProductOptionsViewModel, animated: Bool) {

    }

    func getRequiredHeight() -> CGFloat {
        guard let lastBlock = contentOffsets.last(where: { $0.view.alpha == 1 }) else {
            return Constants.minViewHeight
        }
        let reqiuredHeight = [
            lastBlock.lastOffset,
            lastBlock.topConstraint.constant,
            lastBlock.view.frame.height
        ].reduce(0, +)
        return max(reqiuredHeight, Constants.minViewHeight)
    }

}

// MARK: - Configuration

private extension ProductOptionView {

    func setupInitialState() {
        self.backgroundColor = .clear

    }

}

// MARK: - Actions

private extension ProductOptionView {
}

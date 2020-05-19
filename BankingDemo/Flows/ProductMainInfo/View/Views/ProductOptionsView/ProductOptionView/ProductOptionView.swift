//
//  ProductOptionView.swift
//  ZenitOnline
//

import UIKit

final class ProductOptionView: DesignableView {

    // MARK: - IBOutlets

    @IBOutlet private weak var actionsView: ActionsView!
    @IBOutlet private weak var detailProductView: DetailedProductView!

    // MARK: - Constraints

    @IBOutlet private weak var actionsWidthConstraint: NSLayoutConstraint!
    @IBOutlet private weak var actionsHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var actionsTopContraint: NSLayoutConstraint!

    // MARK: - Properties

    var didSelectAction: Closure<ProductFastActionType>?
    var didSelectCard: Closure<Int?>?

    // MARK: - Private Properties

    private var model = ProductOptionsViewModel(actions: [], card: nil)
    private lazy var cardView = CardView(frame: .init(x: 0, y: 0, width: 60, height: 40))

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
        self.model = model
        actionsView.configure(with: model.actions)
        guard let card = model.card else {
            return
        }
        cardView.configure(with: card)
        detailProductView.setMainView(cardView)
    }

    func getRequiredHeight() -> CGFloat {
        return 200
    }

    func setActionsSize(_ size: CGSize) {
        actionsWidthConstraint.constant = size.width
        actionsHeightConstraint.constant = size.height
    }

    func setActionsAplha(_ newValue: CGFloat) {
        actionsView.setActionsApla(newValue)
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

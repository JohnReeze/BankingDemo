//
//  ProductOptionView.swift
//  ZenitOnline
//

import UIKit

final class ProductOptionView: DesignableView {

    // MARK: - Constants

    private enum Constants {
        static let withDetailOffset: CGFloat = 94
        static let withoutDetailOffset: CGFloat = 60
        static let defaultBottomOffset: CGFloat = 30
    }

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
    private lazy var cardView: CardView = {
        let view = CardView(frame: .init(x: 0, y: 0, width: 60, height: 40))
        let cardWidthConstraint = view.widthAnchor.constraint(equalToConstant: 60)
        cardWidthConstraint.isActive = true
        return view
    }()
    private lazy var addCardView: AddProductView = {
        let view = AddProductView(frame: .init(x: 0, y: 0, width: 60, height: 40))
        let addCardWidthConstraint = view.widthAnchor.constraint(equalToConstant: 60)
        addCardWidthConstraint.isActive = true
        return view
    }()

    // MARK: - UIView

    override func awakeFromNib() {
        super.awakeFromNib()
        setupInitialState()
    }

    // MARK: - Initialization

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupInitialState()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialState()
    }

    // MARK: - Internal Methodss

    func configure(with model: ProductOptionsViewModel) {
        self.model = model
        actionsView.configure(with: model.actions)
        guard let card = model.card else {
            detailProductView.isHidden = true
            return
        }
        detailProductView.isHidden = false
        configureDetailView(cardModel: card)
    }

    func getRequiredHeight(for model: ProductOptionsViewModel) -> CGFloat {
        return [
            model.card.isSome ? Constants.withDetailOffset : Constants.withDetailOffset,
            ActionsView.getRequiredSize(for: model.actions).height,
            Constants.defaultBottomOffset
        ].reduce(0, +)
    }

    func setActionsSize(_ size: CGSize) {
        actionsWidthConstraint.constant = size.width
        actionsHeightConstraint.constant = size.height
    }

    func setActionsAplha(_ newValue: CGFloat) {
        actionsView.setActionsApla(newValue)
        detailProductView.alpha = newValue
    }

}

// MARK: - Configuration

private extension ProductOptionView {

    func setupInitialState() {
        self.backgroundColor = .clear
    }

    func configureDetailView(cardModel: CardViewModel) {
        cardView.configure(with: cardModel)
        detailProductView.setMainView(cardView)
        detailProductView.setAdditionalView(addCardView)
    }

}

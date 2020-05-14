//
//  ActionsView.swift
//  BankingDemo
//

import UIKit

enum ProductFastActionType: Int {
    case requisites
    case replenish
    case pay
    case replenishFromCard
    case payByCard

    var title: String {
        switch self {
        case .requisites:
            return L10n.Actions.requisites
        case .pay:
            return L10n.Actions.pay
        case .replenish:
            return L10n.Actions.replanish
        case .replenishFromCard:
            return L10n.Actions.replenishFromCard
        case .payByCard:
            return L10n.Actions.payByCard
        }
    }

    var isLongTitle: Bool {
        switch self {
        case .replenishFromCard, .payByCard:
            return true
        default:
            return false
        }
    }

    var icon: UIImage {
        switch self {
        case .payByCard, .pay:
            return Styles.Images.pay.image.mask(with: .white).withRenderingMode(.alwaysOriginal)
        case .replenishFromCard, .replenish:
            return Styles.Images.plus.image.mask(with: .white).withRenderingMode(.alwaysOriginal)
        case .requisites:
            return Styles.Images.requisites.image.mask(with: .white).withRenderingMode(.alwaysOriginal)
        }
    }
}

final class ActionsView: UIView {

    // MARK: - Constants

    private enum Constants {
        static let defaultHeight: CGFloat = 90
        static let twoLinesHeight: CGFloat = 110
        static let buttonWidth: CGFloat = (UIScreen.main.bounds.width - 20) * 0.33
    }

    private lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [
            Styles.Colors.darkGrdientStart.color.cgColor,
            Styles.Colors.darkGrdientEnd.color.cgColor
        ]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.locations = [0, 1]
        return gradient
    }()

    // MARK: - Properties

    var didSelectAction: Closure<ProductFastActionType>?
    private let stackView = UIStackView()
    private var actions = [ProductFastActionType]()

    // MARK: - UIView

    override func awakeFromNib() {
        self.layer.masksToBounds = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView)
        stackView.anchor(top: self.topAnchor, leading: nil, bottom: self.bottomAnchor, trailing: nil)
        stackView.anchorCenter(to: self)
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        configureGradient(rect)
        layer.cornerRadius = 20
    }

    static func getRequiredSize(for types: [ProductFastActionType]) -> CGSize {
        guard types.contains(where: { $0.isLongTitle }) else {
            return CGSize(width: Constants.buttonWidth * CGFloat(types.count),
                          height: Constants.defaultHeight)
        }
        return CGSize(width: Constants.buttonWidth * CGFloat(types.count),
                      height: Constants.twoLinesHeight)
    }

    func setActionsApla(_ newValue: CGFloat) {
        stackView.alpha = newValue
    }

    func configure(with models: [ProductFastActionType]) {
        guard actions != models else {
            return
        }
        self.actions = models
        stackView.subviews.forEach { $0.removeFromSuperview() }
        models.map (createButton)
            .forEach { stackView.addArrangedSubview($0) }
    }

}

// MARK: - Private methods

private extension ActionsView {

    func configureGradient(_ rect: CGRect) {
        gradient.frame = rect
        self.layer.insertSublayer(gradient, at: 0)
    }

    func createButton(for type: ProductFastActionType) -> UIButton {
        let size = CGSize(width: Constants.buttonWidth,
                          height: type.isLongTitle ? Constants.twoLinesHeight : Constants.defaultHeight)
        let model = CenteredImageButtonViewModel(title: type.title,
                                                 icon: type.icon,
                                                 font: UIFont.systemFont(ofSize: 13, weight: .regular),
                                                 buttonSize: size,
                                                 imageSize: type.icon.size,
                                                 imageBottomPadding: -10)
        let button = CenteredImageButton(viewModel: model)
        let widthConstrint = button.widthAnchor.constraint(equalToConstant: Constants.buttonWidth)
        NSLayoutConstraint.activate([widthConstrint])
        button.addTarget(self, action: #selector(didSelectFastAction), for: .touchUpInside)
        return button
    }

    @objc
    func didSelectFastAction(_ sender: UIButton) {
        ProductFastActionType(rawValue: sender.tag) ~> didSelectAction
    }

}

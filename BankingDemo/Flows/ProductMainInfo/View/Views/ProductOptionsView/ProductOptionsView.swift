//
//  ProductOptionsView.swift
//  ZenitOnline
//
//  Created by Mikhail Monakov on 21/01/2020.
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

protocol ProductOptionsViewDelegate: class {
    func didSelectAction(_ action: ProductFastActionType)
    func didSelectCard(at index: Int?)
}

final class ProductOptionsView: UIView {

    // MARK: - Enums

    enum State {
        case current
        case next
    }

    // MARK: - UIView

    override func awakeFromNib() {
        super.awakeFromNib()
        setupInitalState()
    }

    // MARK: - Initialization

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupInitalState()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitalState()
    }

    public weak var delegate: ProductOptionsViewDelegate?

    // MARK: - Private Properties

    private lazy var currentStateView = ProductOptionView(frame: .zero)
    private lazy var nextStateView = ProductOptionView(frame: .zero)

    // MARK: - Internal Methods

    func getRequiredHeight(for state: State) -> CGFloat {
        switch state {
        case .current:
            return currentStateView.getRequiredHeight()
        case .next:
            return nextStateView.getRequiredHeight()
        }
    }

    func configureCurrentState(model: ProductOptionsViewModel) {
        currentStateView.configure(with: model)
    }

    func updateCurrentState(topOffset: CGFloat) {
        currentStateView.updateTopOffset(topOffset)
    }

    func updateCurrentState(with model: ProductOptionsViewModel, animated: Bool) {
        currentStateView.update(with: model, animated: animated)
    }

    func configureNextState(model: ProductOptionsViewModel) {
        nextStateView.configure(with: model)
    }

    func setStateChangeProgress(_ progress: Double) {
        currentStateView.alpha = CGFloat(1 - progress * 2)
        nextStateView.alpha = CGFloat(2 * progress - 1)
    }

    func finishStateChange() {
        currentStateView.alpha = 0
        nextStateView.alpha = 1
        swap(&currentStateView, &nextStateView)
    }

}

// MARK: - Configuration

private extension ProductOptionsView {

    func setupInitalState() {
        self.backgroundColor = .clear
        nextStateView.alpha = 0
        for optionView in [currentStateView, nextStateView] {
            optionView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(optionView)
//            optionView.fillSuperview()
            optionView.didSelectCard = weak(self) { $0.delegate?.didSelectCard(at: $1) }
            optionView.didSelectAction = weak(self) { $0.delegate?.didSelectAction($1) }
        }
    }

}

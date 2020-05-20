//
//  ProductOptionsView.swift
//  BankingDemo
//

import UIKit

protocol ProductOptionsViewDelegate: class {
    func didSelectAction(_ action: ProductFastActionType)
}

final class ProductOptionsView: UIView {

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

    private var currentState = CGSize()
    private var nextState = CGSize()
    private var currentModel = ProductOptionsViewModel(actions: [], card: nil)
    private var nextModel = ProductOptionsViewModel(actions: [], card: nil)

    // MARK: - Internal Methods

    func getRequiredHeight(for state: State) -> CGFloat {
        switch state {
        case .current:
            return currentStateView.getRequiredHeight(for: currentModel)
        case .next:
            return currentStateView.getRequiredHeight(for: nextModel)
        }
    }

    func configureCurrentState(model: ProductOptionsViewModel) {
        currentStateView.configure(with: model)
        self.currentModel = model
        self.currentState = ActionsView.getRequiredSize(for: model.actions)
    }

    func configureNextState(model: ProductOptionsViewModel) {
        self.nextModel = model
        self.nextState = ActionsView.getRequiredSize(for: model.actions)
    }

    func setStateChangeProgress(_ progress: Double) {
        let cgProgress = CGFloat(progress)
        let width = currentState.width - (currentState.width - nextState.width) * cgProgress
        let height = currentState.height - (currentState.height - nextState.height) * cgProgress
        currentStateView.setActionsSize(CGSize(width: width, height: height))
        currentStateView.setProgress(cgProgress, from: currentModel, to: nextModel)

        if progress > 0.5 {
            currentStateView.configure(with: nextModel)
            currentStateView.setActionsAplha(CGFloat(2 * progress - 1))
        } else {
            currentStateView.setActionsAplha(CGFloat(1 - progress * 2))
            currentStateView.configure(with: currentModel)
        }
    }

    func finishStateChange() {
        currentState = nextState
        currentModel = nextModel
    }

}

// MARK: - Configuration

private extension ProductOptionsView {

    func setupInitalState() {
        self.backgroundColor = .clear
        currentStateView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(currentStateView)
        currentStateView.fillSuperview()
        currentStateView.didSelectAction = weak(self) { $0.delegate?.didSelectAction($1) }
    }

}

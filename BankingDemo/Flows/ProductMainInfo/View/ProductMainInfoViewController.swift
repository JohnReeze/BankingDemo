//
//  ProductMainInfoViewController.swift
//  BankingDemo
//
//  Created by Mikhail Monakov on 16/01/2020.
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

typealias DetailProductState = Int

final class ProductMainInfoViewController: UIViewController {

    // MARK: - Constants

    private enum Constants {
        static let carouselHeight: CGFloat = 200
    }

    // MARK: - IBOutlets

    @IBOutlet private weak var productsCarousel: ProductsCarouselView!
    @IBOutlet private weak var productOptionsView: ProductOptionsView!
    @IBOutlet private weak var indicator: InfiniteInidicator!

    // MARK: - Constraints

    @IBOutlet private weak var productOptionsViewTopConstraint: NSLayoutConstraint!

    // MARK: - Properties

    var output: ProductMainInfoViewOutput?

    // MARK: - Private Properties

    private var heightConstraint: NSLayoutConstraint?
    private var currentState: DetailProductState = 0
    private var nextState: DetailProductState = 0

    private var headerModels: [ProductHeaderType] = []
    private var optionsModels: [ProductOptionsViewModel] = []
    private var animationBlock: Closure<EmptyClosure>?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        indicator.configure(lenght: 4)
    }

}

// MARK: - ProductMainInfoViewInput

extension ProductMainInfoViewController: ProductMainInfoViewInput {

    func setupInitialState() {
        view.clipsToBounds = true
        configureProductsCarousel()
        productOptionsView.delegate = self
    }

    func configure(with models: [ProductViewModel]) {
        indicator.configure(lenght: models.count)
        configureCarouselModels(for: models)
        configureOptionModels(for: models)
    }

    private func configureCarouselModels(for models: [ProductViewModel]) {
        self.headerModels = models.map {
            if $0.type == .linkedCard {
                let cardModel: CardViewModel? = $0.cardInfo ~> { CardViewModel(number: $0.shorNumber,
                                                                               color: UIColor(hexString: $0.backgroundColor),
                                                                               typeIcon: $0.type.icon,
                                                                               needBorder: $0.isOwn) }
                return .card(.init(id: $0.id,
                                   title: $0.name,
                                   cardModel: cardModel ?? .stub))
            }
            return .regular(.init(id: $0.id,
                                  title: $0.name,
                                  balance: $0.balance,
                                  description: $0.description))
        }
        productsCarousel.configure(with: headerModels, offset: 0, initialPage: 0)
    }

    private func configureOptionModels(for models: [ProductViewModel]) {
        self.optionsModels = models.map {
            let cardModel: CardViewModel? = $0.cardInfo ~> { CardViewModel(number: $0.shorNumber,
                                                                           color: UIColor(hexString: $0.backgroundColor),
                                                                           typeIcon: $0.type.icon,
                                                                           needBorder: $0.isOwn) }
            return .init(actions: $0.type.actions, card: $0.type == .cardAccount ? cardModel : nil)
        }
        optionsModels.first ~> productOptionsView.configureCurrentState
    }

}

// MARK: - ProductOptionsViewDelegate

extension ProductMainInfoViewController: ProductOptionsViewDelegate {

    func didSelectAction(_ action: ProductFastActionType) {
        output?.didSelectAction(action)
    }

}

// MARK: - ContentScrollableHeader

extension ProductMainInfoViewController: ContentScrollableHeader {

    var viewController: UIViewController {
        return self
    }

    func setContentHeightConstraint(_ constraint: NSLayoutConstraint) {
        self.heightConstraint = constraint
    }

    func setAnimationBlock(_ block: @escaping (@escaping EmptyClosure) -> Void) {
        self.animationBlock = block
    }

}

// MARK: - Configuration

private extension ProductMainInfoViewController {

    func configureProductsCarousel() {
        productsCarousel.didScroll = { [weak self] (stateModel, didEndChange) in
            guard let self = self else { return }

            if self.currentState != stateModel.fromPage {
                self.productOptionsView.finishStateChange()
                self.currentState = stateModel.fromPage
            }

            self.productOptionsView.setStateChangeProgress(stateModel.progress)

            if self.nextState != stateModel.toPage {
                self.nextState = stateModel.toPage
                self.productOptionsView.configureNextState(model: self.optionsModels[self.nextState])
            }

            let currHeight = self.productOptionsView.getRequiredHeight(for: .current)
            let nextHeight = self.productOptionsView.getRequiredHeight(for: .next)
            let expectedHeight = Constants.carouselHeight + currHeight - (currHeight - nextHeight) * CGFloat(stateModel.progress)
            self.heightConstraint?.constant = expectedHeight
            self.output?.didStateChanged(stateModel)

            self.indicator.set(progress: stateModel.progress, from: stateModel.fromPage, to: stateModel.toPage)
        }
    }

}

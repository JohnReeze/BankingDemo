//
//  ProductMainInfoViewController.swift
//  ZenitOnline
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

        let mock1: ProductHeaderType = .regular(.init(id: "1", title: "Счет Tinkoff Black", balance: "123 324, 23", description: "За текущий период вы получите"))
        var models = Array(repeating: mock1, count: 3)

        let mock2: ProductHeaderType = .card(.init(id: "2", title: "Альфа Банк", cardModel: CardViewModel(number: "1234", color: .red, logo: nil, typeIcon: CardType.visa.icon)))

        models.append(mock2)

        productsCarousel.configure(with: models,
                                   offset: 0.0,
                                   initialPage: 0)

        headerModels = models
        indicator.configure(lenght: models.count)

        optionsModels = [
            .init(actions: [.requisites, .replenish, .pay], card: CardViewModel(number: "1234", color: .red, logo: nil, typeIcon: CardType.visa.icon)),
            .init(actions: [.requisites, .pay], card: nil),
            .init(actions: [.payByCard, .replenishFromCard], card: nil),
            .init(actions: [.requisites, .pay], card: nil)
        ]
        productOptionsView.configureCurrentState(model: .init(actions: [.requisites, .replenish, .pay], card:  CardViewModel(number: "1234", color: .red, logo: nil, typeIcon: CardType.masterCard.icon)))
    }

//    func update(with models: [ProductMainInfoViewModel], selectedIndex: Int?) {
//        currentState = selectedIndex ?? 0
//        nextState = self.currentState
//        self.models = models
//
//        headerModels = models.map {
//            ($0.localCard ~> { .card($0) }) ?? .regular(.init(id: $0.id,
//                                                              balance: $0.balance,
//                                                              descriptions: $0.desciptions,
//                                                              isHidden: $0.isHiddenBalance))
//        }
//
//        let requiredHeights = headerModels.map { productsCarousel.getRequiredHeight(for: $0) }
//
//        optionsModels = zip(models, requiredHeights).map {
//            ProductOptionsViewModel(topOffset: max(0, $0.1 - Constants.carouselHeight),
//                                    actions: $0.0.productActions,
//                                    cards: ($0.0.cards ?? [], $0.0.selectedCard),
//                                    cardsStatus: $0.0.cardsStatus)
//        }
//
//        productsCarousel.configure(with: headerModels, offset: 0, initialPage: currentState)
//        productOptionsView.configureCurrentState(model: optionsModels[currentState])
//        productOptionsView.configureNextState(model: optionsModels[currentState])
//        let currHeight = self.productOptionsView.getRequiredHeight(for: .current)
//        self.heightConstraint?.constant = Constants.carouselHeight + currHeight
//    }

    func setLoading(_ isLoading: Bool) {
//        productsCarousel.setLoading(isLoading)
    }

}

// MARK: - ProductOptionsViewDelegate

extension ProductMainInfoViewController: ProductOptionsViewDelegate {

    func didSelectAction(_ action: ProductFastActionType) {
        output?.didSelectAction(action)
    }

    func didSelectCard(at index: Int?) {
        output?.didSelectCard(at: index)
    }

}

// MARK: - ContentScrollableHeader

extension ProductMainInfoViewController: ContentScrollableHeader {

    func setContentOffset(_ newOffset: CGFloat) {

    }

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

        productsCarousel.didSelectHideOption = weak(self) { $0.output?.didSelectHideOption() }
    }

}

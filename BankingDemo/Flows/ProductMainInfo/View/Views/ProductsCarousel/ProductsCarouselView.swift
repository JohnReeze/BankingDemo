//
//  ProductsCarouselView.swift
//  BankingDemo
//

import UIKit

final class ProductsCarouselView: DesignableView {

    // MARK: - IBOutlets

    @IBOutlet private weak var collectionView: UICollectionView!

    // MARK: - Private Properties

    private var adapter: ProductCarouselAdapter?
    var didScroll: ProductStateChangeEvent?
    var didSelectHideOption: EmptyClosure?

    // MARK: - UIView

    override func awakeFromNib() {
        super.awakeFromNib()
        setupInitialState()
    }

    // MARK: - Internal Methods

    func configure(with models: [ProductHeaderType], offset: CGFloat, initialPage: Int) {
        adapter?.configure(with: models, offset: offset, initialPage: initialPage)
    }

    func getRequiredHeight(for model: ProductHeaderType) -> CGFloat {
        return adapter?.getHeight(for: model) ?? .zero
    }

}

// MARK: - Configuration

private extension ProductsCarouselView {

    func setupInitialState() {
        self.backgroundColor = .clear
        configureCarouselAdapter()
    }

    func configureCarouselAdapter() {
        adapter = ProductCarouselAdapter(with: collectionView)
        adapter?.didScroll = { [weak self] (stateModel, didEndChanged) in
            guard let self = self else { return }
            self.didScroll?(stateModel, didEndChanged)
        }

        adapter?.didSelectHideOption = weak(self) { $0.didSelectHideOption?() }
        collectionView.delegate = adapter
        collectionView.dataSource = adapter
        collectionView.backgroundColor = .clear
    }

}

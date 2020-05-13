//
//  ProductsCarouselAdapter.swift
//  ZenitOnline
//

import UIKit

typealias ProductStateChangeEvent = (_ model: ProductStateViewModel, _ endDecelerating: Bool) -> Void

final class ProductCarouselAdapter: NSObject, UICollectionViewDelegate {

    // MARK: - Constants

    private enum Constants {
        static let maxItemsNumbers = 2000
        static let pageWidth = UIScreen.main.bounds.width
        static let pageHeight: CGFloat = 200
    }

    // MARK: - Private Properties

    private let collectionView: UICollectionView
    private var currentOffset: CGFloat = 0
    private var currentNormalizedPage = 0
    private var currentPage: CGFloat = 0
    private var models: [ProductHeaderType] = []

    // MARK: - Public Properties

    var didScroll: ProductStateChangeEvent?
    var didSelectHideOption: EmptyClosure?

    // MARK: - Initialization

    init(with collectionView: UICollectionView) {
        collectionView.backgroundColor = UIColor.clear
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.registerNib(PlainProductCell.self)
        collectionView.registerNib(CardProductHeaderCell.self)

        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: Constants.pageWidth, height: Constants.pageHeight)
            layout.invalidateLayout()
        }

        self.collectionView = collectionView
    }

    // MARK: - Interface Methods

    func configure(with models: [ProductHeaderType], offset: CGFloat, initialPage: Int) {
        self.models = models
        self.currentOffset = offset
        self.currentNormalizedPage = initialPage
        collectionView.reloadData()

        DispatchQueue.main.async { [weak self] in
            // simulate an infinite carousel and select as the first element a cell in the middle
            guard let self = self else { return }
            guard let startIndex = self.carouselStartIndex(with: initialPage) else {
                return
            }
            self.currentPage = CGFloat(startIndex)
            self.collectionView.scrollToItem(at: .init(item: startIndex, section: 0),
                                             at: .centeredHorizontally,
                                             animated: false)
        }
    }

    func getHeight(for model: ProductHeaderType) -> CGFloat {
        return Constants.pageHeight
    }

}

// MARK: - UICollectionViewDataSource

extension ProductCarouselAdapter: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch models.count {
        case .zero:
            return 0
        case 1:
            return 1
        default:
            return Constants.maxItemsNumbers
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch models[indexPath.row % models.count] {
        case .regular(let model):
            return getPlainProductCell(collectionView: collectionView, indexPath: indexPath, for: model)
        case .card(let model):
            return getCardCell(collectionView: collectionView, indexPath: indexPath, for: model)
        }
    }

    func getPlainProductCell(collectionView: UICollectionView, indexPath: IndexPath, for model: ProductHeaderType.PlainProductModel) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(PlainProductCell.self, indexPath: indexPath) else {
            return UICollectionViewCell()
        }
        return cell
    }

    func getCardCell(collectionView: UICollectionView, indexPath: IndexPath, for model: ProductHeaderType.LinkedCardModel) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(CardProductHeaderCell.self, indexPath: indexPath) else {
            return UICollectionViewCell()
        }
        cell.configure(title: model.title, cardModel: model.cardModel)
        return cell
    }

}

// MARK: - UIScrollViewDelegate

extension ProductCarouselAdapter: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.x
        let normalizedOffset = offset + scrollView.contentInset.left

        // real progress
        let progress = (normalizedOffset / Constants.pageWidth)
        let diff = currentPage - progress

        if diff >= 1 {
            self.currentPage = progress.rounded(.up)
            self.currentNormalizedPage = Int(self.currentPage) % models.count
        } else if diff <= -1 {
            self.currentPage = progress.rounded(.down)
            self.currentNormalizedPage = Int(self.currentPage) % models.count
        }

        let indexTo = diff > 0.0 ? Int(progress.rounded(.down)) % models.count : Int(progress.rounded(.up)) % models.count
        let scrollProgress = Double(abs(diff))
        let scrollModel = ProductStateViewModel(progress: scrollProgress >= 1 ? 0 : scrollProgress, fromPage: currentNormalizedPage, toPage: indexTo)
        didScroll?(scrollModel, false)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let scrollModel = ProductStateViewModel(progress: 0, fromPage: currentNormalizedPage, toPage: currentNormalizedPage)
        didScroll?(scrollModel, true)
    }

}

// MARK: - Private Logic

private extension ProductCarouselAdapter {

    func carouselStartIndex(with initialPage: Int) -> Int? {
        switch models.count {
        case 0:
            return nil
        case 1:
            return 0
        default:
            let midIndex = Constants.maxItemsNumbers / 2
            return midIndex - midIndex % models.count + initialPage
        }
    }

}

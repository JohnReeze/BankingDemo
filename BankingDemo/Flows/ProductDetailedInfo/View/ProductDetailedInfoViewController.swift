//
//  ProductDetailedInfoViewController.swift
//  ZenitOnline
//

import UIKit

protocol ProductDetailedInfoViewProtocol: UIViewController, ContentSourceable, ContentAnimatable {
    var scrollableDelegate: ContentScrollable? { get set }
}

final class ProductDetailedInfoViewController: UIViewController {

    // MARK: - Constants

    private enum Constants {
        static let shadowSpaceOffset: CGFloat = 5
    }

    // MARK: - Nested types

    struct State {
        let progress: CGFloat
        let from: Int
        let to: Int
    }

    // MARK: - IBOutlets

    @IBOutlet private weak var pageContainer: UIView!
    @IBOutlet private weak var expensesView: ExpensesView!
    @IBOutlet private weak var segmentBlurView: UIView!
    @IBOutlet private weak var contentBlurView: UIView!

    // MARK: - Private Properties

    private var animationBlock: Closure<EmptyClosure>?

    var historyContent: ContentCollaborative?
    weak var scrollableDelegate: ContentScrollable?
    var output: ProductDetailedInfoViewOutput?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        historyContent?.collaborativeView ~> { scrollableDelegate?.didChangeSource(newSource: $0.scrollView) }
    }

}

// MARK: - ProductDetailedInfoViewProtocol

extension ProductDetailedInfoViewController: ProductDetailedInfoViewProtocol {

    var viewController: UIViewController {
        return self
    }

    func setAnimationBlock(_ block: @escaping Closure<EmptyClosure>) {
        self.animationBlock = block
    }

}

// MARK: - ProductDetailedInfoViewInput

extension ProductDetailedInfoViewController: ProductDetailedInfoViewInput {

    func setupInitialState() {
        configureContentView()
    }

    func setStateChangeProgress(_ progress: Double) {
        let progress = 2 * CGFloat(progress)
        let alpha: CGFloat = progress < 1 ? progress : 2 - progress
        segmentBlurView.alpha = CGFloat(alpha)
        contentBlurView.alpha = CGFloat(alpha)
    }

    func configure(models: [(type: ExpenseType, part: Double)]) {
        let models: [(type: ExpenseType, part: Double)] = [
            (type: .cash, part: 0.3),
            (type: .supermarket, part: 0.6),
            (type: .fastfood, part: 0.1)
        ]
        expensesView.configure(title: "Траты за май", sum: "123 32,34 $",
                               expensesInfo: models)
    }

}

// MARK: - UIScrollViewDelegate

extension ProductDetailedInfoViewController: UIScrollViewDelegate {

}

// MARK: - Configuration

private extension ProductDetailedInfoViewController {

    func configureContentView() {
        guard let content = historyContent else {
            return
        }
        self.addChild(content)
        self.pageContainer.addSubview(content.view)
        content.didMove(toParent: self)
        content.view.translatesAutoresizingMaskIntoConstraints = false
        content.view.fillSuperview()
        content.didScroll = { [weak self] contentView in
            self?.scrollableDelegate?.didScroll(in: contentView.scrollView)
        }
        view.layoutIfNeeded()
    }

    func configureBlurViews() {
        segmentBlurView.isHidden = false
        segmentBlurView.backgroundColor = Styles.Colors.main.color
        segmentBlurView.alpha = 0

        contentBlurView.isHidden = false
        contentBlurView.backgroundColor = Styles.Colors.main.color
        contentBlurView.alpha = 0
    }

}

//
//  ProductDetailedInfoViewController.swift
//  BankingDemo
//

import UIKit

protocol ProductDetailedInfoViewProtocol: UIViewController, ContentSourceable, ContentAnimatable {
    var scrollableDelegate: ContentScrollable? { get set }
}

final class ProductDetailedInfoViewController: UIViewController {

    // MARK: - Constants

    private enum Constants {
        static let defaultOffset: CGFloat = 64
    }

    // MARK: - IBOutlets

    @IBOutlet private weak var pageContainer: UIView!
    @IBOutlet private weak var expensesView: ExpensesView!

    // MARK: - Private Properties

    @IBOutlet private weak var pageTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var expensesHeightConstraint: NSLayoutConstraint!
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
        view.backgroundColor = Styles.Colors.main.color
    }

    func setExpensesOption(_ isEnabled: Bool) {
        expensesView.isHidden = !isEnabled
    }

    func setProgress(_ progress: Double, hadExpenses: Bool, willHaveExpenses: Bool) {
        if willHaveExpenses && progress > 0 {
            expensesView.alpha = CGFloat(2 * progress - 1)
        } else if hadExpenses {
            expensesView.alpha = CGFloat(1 - progress * 2)
        }

        let fromOffset = hadExpenses ? Constants.defaultOffset : 0
        let toOffset = willHaveExpenses ? Constants.defaultOffset : 0
        pageTopConstraint.constant = fromOffset - CGFloat(progress) * (fromOffset - toOffset)
    }

    func configure(model: ExpensesModel) {
        animationBlock? {
            self.expensesView.configure(title: model.month,
                                        sum: model.sumString,
                                        expensesInfo: model.spendings)
        }
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

}

//
//  DetailProduct.swift
//  BankingDemo
//

import UIKit

final class DetailProductViewController: UIViewController, ModuleTransitionable {

    // MARK: - Nested types

    private enum ScrollDirection: Int {
        case up
        case down
    }

    // MARK: - Constants

    private enum Constants {
        static let positionKeyPath = "contentOffset"
        static let titleViewDefaultWidth: CGFloat = 200
        static let titleViewDefaultHeight: CGFloat = 44
        static let navbarSettingsTreshold: CGFloat = 36
    }

    // MARK: - IBOutlets

    @IBOutlet private weak var gradientView: UIView!
    @IBOutlet private weak var mainScrollView: CollaborativeScrollView!

    @IBOutlet private weak var headerContainer: UIView!
    @IBOutlet private weak var pagesContainer: UIView!

    // MARK: - Properties

    var headerContent: ContentScrollableHeader?
    var mainContent: ProductDetailedInfoViewProtocol?
    var output: DetailProductViewOutput?

    // MARK: - Private Properties

    private var nameModel: DetailProductNameModel?
    private var refreshControl: UIRefreshControl?
//    private var navigationTitle: DualNavBarTitleView?
    private var scrollDirection: ScrollDirection?

    private var settingsIsShowed = false

    private var maxHeaderScrollOffset: CGFloat {
        return headerConstraint.constant
    }

    private var minimumContentHeight: CGFloat {
        let navBarHeight = self.navigationController?.navigationBar.frame.height ?? 0.0
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        return UIScreen.main.bounds.height - navBarHeight - statusBarHeight - headerConstraint.constant
    }

    private var innerScrollView: UIScrollView?

    // MARK: - Constraints

    @IBOutlet private weak var headerConstraint: NSLayoutConstraint!
    @IBOutlet private weak var pagesConstraint: NSLayoutConstraint!

//    private let

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        output?.viewDidAppear()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        output?.viewWillDisappear()
    }

    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey: Any]?,
                               context: UnsafeMutableRawPointer?) {
        guard keyPath == Constants.positionKeyPath else {
            return
        }
        handleMainScrollViewOffsetChange(mainScrollView.contentOffset.y)
    }

}

// MARK: - DetailProductViewInput

extension DetailProductViewController: DetailProductViewInput {

    func setupInitialState() {
        configureUI()
    }

    func configure(with model: DetailProductNameModel) {
//        navigationTitle?.configure(with: model.title,
//                                   subtitle: model.subTitle,
//                                   animated: true)
        self.nameModel = model
    }

}

 // MARK: - ContentScrollable

extension DetailProductViewController: ContentScrollable {

    func didScroll(in scrollView: UIScrollView) {
        handleScroll(scrollView)
    }

    func didChangeSource(newSource: UIScrollView) {
        self.innerScrollView = newSource
    }

}

// MARK: - UIScrollViewDelegate

extension DetailProductViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollDirection = mainScrollView.lastContentOffset.y < scrollView.contentOffset.y ? .up : .down
        headerContent?.setContentOffset(scrollView.contentOffset.y)
        handleScroll(mainScrollView)

    }

    private func handleScroll(_ scrollView: UIScrollView) {
        guard let csv = scrollView as? CollaborativeView else {
            return
        }

        guard let innerScrollView = innerScrollView else {
            return
        }

        let mainOffset = mainScrollView.contentOffset.y

        if csv.scrollView === innerScrollView {
            if mainOffset < maxHeaderScrollOffset {
                csv.scrollView.contentOffset = csv.lastContentOffset
            }
            if csv.scrollView.contentOffset.y < -csv.scrollView.contentInset.top {
                csv.scrollView.contentOffset.y = -csv.scrollView.contentInset.top
            }
        } else {
            if innerScrollView.contentOffset.y > -innerScrollView.contentInset.top || csv.scrollView.contentOffset.y > maxHeaderScrollOffset {
                mainScrollView.contentOffset.y = maxHeaderScrollOffset
            }

            let contentHeight = [innerScrollView.contentSize.height, innerScrollView.contentInset.bottom, innerScrollView.contentInset.top].reduce(0, +)
            let mainScrollTopInset: CGFloat

            if #available(iOS 11.0, *) {
                mainScrollTopInset = -mainScrollView.adjustedContentInset.top
            } else {
                mainScrollTopInset = -mainScrollView.contentInset.top
            }

            if contentHeight < minimumContentHeight
                && mainScrollView.lastContentOffset.y < csv.scrollView.contentOffset.y
                && csv.scrollView.contentOffset.y > mainScrollTopInset {
                mainScrollView.contentOffset = mainScrollView.lastContentOffset
            }
        }
        csv.lastContentOffset = csv.contentOffset
    }

    func handleMainScrollViewOffsetChange(_ yOffset: CGFloat) {
        showSettingsIfNeeded(offset: yOffset)
    }

}

// MARK: - Configuration

private extension DetailProductViewController {

    func configureUI() {
        configureNavigationBar()
        configureRefreshControl()
        setupMainScrollView()
        setupHeader()
        setupPages()
        configurePagesHeight()
    }

    func setupMainScrollView() {
        mainScrollView.addObserver(self, forKeyPath: Constants.positionKeyPath, options: .new, context: nil)
        mainScrollView.translatesAutoresizingMaskIntoConstraints = false
        mainScrollView.showsVerticalScrollIndicator = false
        mainScrollView.isHidden = true
        mainScrollView.delegate = self
        mainScrollView.alwaysBounceVertical = false
        mainScrollView.scrollsToTop = false
    }

    func configureRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshProductList), for: .valueChanged)
        refreshControl ~> { mainScrollView.addSubview($0) }
    }

    func configureNavigationBar() {
        navigationController?.applyStandartNavigationBarStyle()
        let settings = UIButton(type: .custom)
        settings.setImage(Styles.Images.settings.image.withRenderingMode(.alwaysOriginal), for: .normal)
        settings.frame = CGRect(x: 0.0, y: 0.0, width: 35.0, height: 35.0)
        settings.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: settings)
        // TODO: remove test code and make title view
        title = "Счет Tinkoff"
    }

    func setupHeader() {
        guard let header = headerContent?.viewController else {
            return
        }

        headerContent?.setAnimationBlock(self.animationBlock)
        self.addChild(header)
        self.headerContainer.addSubview(header.view)
        header.didMove(toParent: self)
        header.view.translatesAutoresizingMaskIntoConstraints = false
        headerContent?.setContentHeightConstraint(headerConstraint)

        header.view.fillSuperview()
        view.layoutIfNeeded()
        self.mainScrollView.isHidden = false
    }

    func setupPages() {
        guard let pagesController = mainContent?.viewController else {
            return
        }

        mainContent?.setAnimationBlock(self.animationBlock)
        mainContent?.scrollableDelegate = self

        self.addChild(pagesController)
        pagesContainer.addSubview(pagesController.view)
        pagesController.didMove(toParent: self)
        pagesController.view.translatesAutoresizingMaskIntoConstraints = false
        pagesController.view.fillSuperview()
    }

    func configurePagesHeight() {
        let navBarHeight = self.navigationController?.navigationBar.frame.height ?? 0.0
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        pagesConstraint.constant = UIScreen.main.bounds.height - navBarHeight - statusBarHeight
    }

    func showSettingsIfNeeded(offset: CGFloat) {
        guard let customView = navigationItem.rightBarButtonItem?.customView else {
            return
        }

        let animation: Closure<EmptyClosure> = {
            UIView.animate(withDuration: Durations.animation,
                           delay: 0,
                           options: [.beginFromCurrentState],
                           animations: $0,
                           completion: nil)
        }
        if offset > Constants.navbarSettingsTreshold && !settingsIsShowed {
            settingsIsShowed = true
            customView.layer.removeAllAnimations()
            animation({ customView.transform = CGAffineTransform(rotationAngle: 3 * .pi).scaledBy(x: 1, y: 1)})
        } else if offset <= Constants.navbarSettingsTreshold && settingsIsShowed {
            settingsIsShowed = false
            animation({ customView.transform = CGAffineTransform(rotationAngle: 2 * .pi).scaledBy(x: 0.01, y: 0.01) })
        }
    }

}

// MARK: - Private actions

private extension DetailProductViewController {

    @objc
    func refreshProductList() {
        output?.updateAction()
        refreshControl?.endRefreshing()
    }

    @objc
    func close() {
        output?.closeAction()
    }

}

// MARK: - UIViewController

private extension UIViewController {

    var animationBlock: Closure<EmptyClosure> {
        return { [weak self] animations in
            UIView.animate(withDuration: Durations.animation, animations: {
                animations()
                self?.view.layoutIfNeeded()
            })
        }
    }

}

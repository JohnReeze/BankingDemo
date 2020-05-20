//
//  ContentCollaborativeViewController.swift
//  BankingDemo
//

import UIKit

protocol TableViewModel {
    func configure(_ tableView: UITableView)
}

protocol ContentCollaborative: UIViewController {
    var didScroll: Closure<CollaborativeView>? { get set }
    var collaborativeView: CollaborativeView? { get }
}

final class ContentCollaborativeViewController: UIViewController, ModuleTransitionable, ContentCollaborative {

    // MARK: - IBOutlets

    @IBOutlet private weak var tableView: CollaborativeTableView!

    // MARK: - Properties

    var output: ContentCollaborativeViewOutput?
    var collaborativeView: CollaborativeView? {
        return safeCollaborativeView
    }
    var didScroll: Closure<CollaborativeView>?

    // MARK: - Private Properties
    // important that cant use tableView because it can be before it view was loaded
    private weak var safeCollaborativeView: CollaborativeTableView?

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
    }

    func configure(viewModel: TableViewModel) {
        viewModel.configure(tableView)
    }

}

// MARK: - ContentCollaborativeViewInput

extension ContentCollaborativeViewController: ContentCollaborativeViewInput {

    func setupInitialState() {
        tableView.separatorStyle = .none
        self.safeCollaborativeView = tableView
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
    }

}

// MARK: - UIScrollViewDelegate

extension ContentCollaborativeViewController: UITableViewDelegate, UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        didScroll?(tableView)
    }

}

//
//  ContentScrollableHeader.swift
//  BankingDemo
//

import UIKit

protocol ContentScrollableHeader: class, ContentAnimatable, ContentSourceable {
    func setContentHeightConstraint(_ constraint: NSLayoutConstraint)
}

protocol ContentAnimatable {
    func setAnimationBlock(_ block: @escaping Closure<EmptyClosure>)
}

protocol ContentSourceable {
    var viewController: UIViewController { get }
}

protocol ContentScrollable: class {
    func didScroll(in scrollView: UIScrollView)
    func didChangeSource(newSource: UIScrollView)
}

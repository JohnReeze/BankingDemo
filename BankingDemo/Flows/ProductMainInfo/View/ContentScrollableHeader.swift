//
//  ContentScrollableHeader.swift
//  ZenitOnline
//
//  Created by Mikhail Monakov on 30/01/2020.
//  Copyright © 2020 Surf. All rights reserved.
//

import UIKit

protocol ContentScrollableHeader: class, ContentAnimatable, ContentSourceable {
    func setContentOffset(_ newOffset: CGFloat)
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

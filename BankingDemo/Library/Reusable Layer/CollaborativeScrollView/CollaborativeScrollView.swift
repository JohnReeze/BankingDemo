//
//  CollaborativeScrollView.swift
//  BankingDemo
//

import UIKit

/// Describes scrollable view, that can be used in other scroll view
public protocol CollaborativeView: class {
    var lastContentOffset: CGPoint { get set }
    var scrollView: UIScrollView { get }
    var contentOffset: CGPoint { get set }
}

/// Implementation for Collection
public final class CollaborativeCollectionView: UICollectionView, UIGestureRecognizerDelegate, CollaborativeView {

    public var lastContentOffset = CGPoint(x: 0, y: 0)

    public var scrollView: UIScrollView {
        return self
    }

    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return otherGestureRecognizer.view is CollaborativeView
    }
}

/// Implementation for ScrollView
public class CollaborativeScrollView: UIScrollView, UIGestureRecognizerDelegate, CollaborativeView {

    public var lastContentOffset = CGPoint(x: 0, y: 0)

    public var scrollView: UIScrollView {
        return self
    }

    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return otherGestureRecognizer.view is CollaborativeView
    }
}

/// Implementation for TableView
public final class CollaborativeTableView: UITableView, UIGestureRecognizerDelegate, CollaborativeView {

    public var lastContentOffset = CGPoint(x: 0, y: 0)

    public var scrollView: UIScrollView {
        return self
    }

    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return otherGestureRecognizer.view is CollaborativeView
    }
}

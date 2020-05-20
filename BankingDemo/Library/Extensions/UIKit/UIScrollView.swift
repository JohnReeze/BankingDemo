//
//  UIScrollView.swift
//  BankingDemo
//

import UIKit

extension UIScrollView {

    func breakUserSwipe() {
        guard panGestureRecognizer.isEnabled else {
            return
        }

        panGestureRecognizer.isEnabled = false
        panGestureRecognizer.isEnabled = true
    }

}

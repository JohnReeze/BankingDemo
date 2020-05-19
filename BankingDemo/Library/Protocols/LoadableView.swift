//
//  LoadableView.swift
//  BankingDemo
//

import UIKit

protocol LoadableView {
    var loadingViews: [UIView] { get }
    func showLoading(_ isLoading: Bool)
}

extension LoadableView {

    func showLoading(_ isLoading: Bool) {
        guard isLoading else {
            loadingViews.forEach {
                $0.layer.removeAllAnimations()
                $0.alpha = 1
            }
            return
        }

        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: [.beginFromCurrentState, .autoreverse, .repeat],
                       animations: {
                        self.loadingViews.forEach { $0.alpha = 0.6 }
        }, completion: nil)
    }

}

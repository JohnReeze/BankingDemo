//
//  UINavigationController.swift
//  BankingDemo
//

import UIKit

extension UINavigationController {

    func applyStandartNavigationBarStyle() {
        navigationBar.barTintColor = Styles.Colors.main.color
        navigationBar.tintColor = Styles.Colors.main.color
        navigationBar.isTranslucent = false
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
    }

}

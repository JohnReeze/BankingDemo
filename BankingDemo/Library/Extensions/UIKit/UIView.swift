//
//  UIView.swift
//  BankingDemo
//

import UIKit

public extension UIView {

    func fillSuperview() {
        anchor(top: superview?.topAnchor,
               leading: superview?.leadingAnchor,
               bottom: superview?.bottomAnchor,
               trailing: superview?.trailingAnchor)
    }

    func anchorSize(to view: UIView) {
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }

    func anchorSize(size: CGSize) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: size.width).isActive = true
        heightAnchor.constraint(equalToConstant: size.height).isActive = true
    }

    func anchorCenter(to view: UIView, xOffset: CGFloat = 0.0, yOffset: CGFloat = 0.0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: xOffset).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: yOffset).isActive = true
    }

    func anchorCenter(centerX: NSLayoutXAxisAnchor? = nil, centerY: NSLayoutYAxisAnchor? = nil, xOffset: CGFloat = 0.0, yOffset: CGFloat = 0.0) {
        translatesAutoresizingMaskIntoConstraints = false

        if let centerX = centerX {
            centerXAnchor.constraint(equalTo: centerX, constant: xOffset).isActive = true
        }

        if let centerY = centerY {
            centerYAnchor.constraint(equalTo: centerY, constant: yOffset).isActive = true
        }
    }

    func anchor(top: NSLayoutYAxisAnchor? = nil, leading: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, trailing: NSLayoutXAxisAnchor? = nil, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false

        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }

        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }

        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }

        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }

        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }

        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }

    func setX(_ x: CGFloat) {
        var frame: CGRect = self.frame
        frame.origin.x = x
        self.frame = frame
    }

}

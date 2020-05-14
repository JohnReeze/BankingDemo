//
//  String.swift
//  BankingDemo
//

import UIKit

extension String {

    func height(withConstrainedWidth width: CGFloat, font: UIFont, lineSpacing: CGFloat? = nil) -> CGFloat {
        var attributes: [NSAttributedString.Key: Any] = [.font: font]
        if let lineSpacing = lineSpacing {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = lineSpacing
            attributes[.paragraphStyle] = paragraphStyle
        }

        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)

        return ceil(boundingBox.height)
    }

}

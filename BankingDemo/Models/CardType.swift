//
//  CardType.swift
//  BankingDemo
//

import UIKit

enum CardType {
    case masterCard
    case visa
    case mir

    var icon: UIImage {
        switch self {
        case .mir:
            return Styles.Images.CardType.mir.image
        case .visa:
            return Styles.Images.CardType.visa.image
        case .masterCard:
            return Styles.Images.CardType.master.image
        }
    }

}

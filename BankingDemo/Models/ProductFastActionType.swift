//
//  ProductFastActionType.swift
//  BankingDemo
//

import UIKit

enum ProductFastActionType: Int {
    case requisites
    case replenish
    case pay
    case replenishFromCard
    case payByCard

    var title: String {
        switch self {
        case .requisites:
            return L10n.Actions.requisites
        case .pay:
            return L10n.Actions.pay
        case .replenish:
            return L10n.Actions.replanish
        case .replenishFromCard:
            return L10n.Actions.replenishFromCard
        case .payByCard:
            return L10n.Actions.payByCard
        }
    }

    var isLongTitle: Bool {
        switch self {
        case .replenishFromCard, .payByCard:
            return true
        default:
            return false
        }
    }

    var icon: UIImage {
        switch self {
        case .payByCard, .pay:
            return Styles.Images.pay.image.mask(with: .white).withRenderingMode(.alwaysOriginal)
        case .replenishFromCard, .replenish:
            return Styles.Images.plus.image.mask(with: .white).withRenderingMode(.alwaysOriginal)
        case .requisites:
            return Styles.Images.requisites.image.mask(with: .white).withRenderingMode(.alwaysOriginal)
        }
    }
}

extension FinanceProductType {

    var actions: [ProductFastActionType] {
        switch self {
        case .cardAccount:
            return [.requisites, .replenish, .pay]
        case .deposit:
            return [.requisites, .replenish]
        case .linkedCard:
            return [.replenishFromCard, .payByCard]
        }
    }

}

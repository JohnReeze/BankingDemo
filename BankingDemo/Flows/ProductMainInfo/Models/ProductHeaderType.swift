//
//  ProductHeaderType.swift
//  BankingDemo
//

import UIKit

struct ProductStateViewModel {
    let progress: Double // [0, 1]
    let fromPage: Int
    let toPage: Int // equals to from page when reaches center of page
}

enum ProductHeaderType: Equatable {
    case regular(PlainProductModel)
    case card(LinkedCardModel)

    struct PlainProductModel: Equatable {
        let id: String
        let title: String
        let balance: String
        let description: String?
    }

    struct LinkedCardModel {
        let id: String
        let title: String
        let cardModel: CardViewModel
    }

    static func == (lhs: ProductHeaderType, rhs: ProductHeaderType) -> Bool {
        switch (lhs, rhs) {
        case (.regular(let lhsModel), .regular(let rhsModel)):
            return lhsModel.id == rhsModel.id
        case (.card(let lhsModel), .card(let rhsModel)):
            return lhsModel.id == rhsModel.id
        default:
            return false
        }
    }

}

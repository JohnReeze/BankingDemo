//
//  ProductViewModel.swift
//  BankingDemo
//

struct ProductViewModel {
    let id: String
    let type: FinanceProductType
    let name: String
    let cardInfo: CardInfo?
    let sum: Double
    let currency: Currency
    let description: String?

    var balance: String {
        return [sum.formattedDoubleValue, currency.sign].joined(separator: " ")
    }
}

struct CardInfo {
    let shorNumber: String
    let backgroundColor: String
    let type: CardType
    let isOwn: Bool
}

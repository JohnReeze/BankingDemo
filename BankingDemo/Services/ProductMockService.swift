//
//  ProductMockService.swift
//  BankingDemo
//

final class ProdcutMockService: ProductService {

    func loadProducts(completion: (Result<[ProductViewModel], Error>) -> Void) {
        let mockModels: [ProductViewModel] = [
            .init(id: "1",
                  type: .cardAccount,
                  name: "Счет Tinkoff Black",
                  cardInfo: .init(shorNumber: "1234", backgroundColor: "1E1E1E", type: .visa, isOwn: true),
                  sum: 123456.78,
                  currency: .init(code: 643, name: "RUB", strCode: "643"),
                  description: "За текущий расчетный период\nвы заработаете 250 ₽ кэшбека"),
            .init(id: "2",
                  type: .deposit,
                  name: "Вклад",
                  cardInfo: nil,
                  sum: 400000.33,
                  currency: .init(code: 643, name: "RUB", strCode: "643"),
                  description: "Сроком на 5 мес. до 23 авг. 2020\nПроцентная ставка: 10 %"),
            .init(id: "3",
                  type: .linkedCard,
                  name: "Альфа Банк",
                  cardInfo: .init(shorNumber: "5678", backgroundColor: "FB2922", type: .mir, isOwn: false),
                  sum: 0,
                  currency: .init(code: 643, name: "RUB", strCode: "643"),
                  description: nil),
            .init(id: "4",
                  type: .linkedCard,
                  name: "Сбербанк",
                  cardInfo: .init(shorNumber: "1012", backgroundColor: "10911F", type: .visa, isOwn: true),
                  sum: 0,
                  currency: .init(code: 643, name: "RUB", strCode: "643"),
                  description: nil)
        ]
        completion(.success(mockModels))
    }

}

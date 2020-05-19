//
//  HistoryExpensesParser.swift
//  BankingDemo
//

final class HistoryExpensesParser {

    func calculate(model: HistoryEntity) -> ExpensesModel {
        return .init(spendings: [
            (.cash, 0.35),
            (.supermarket, 0.2),
            (.fastfood, 0.1),
            (.other, 0.25)
            ],
                     month: "Траты за май",
                     sumString: "44 444,12 ")
    }

}

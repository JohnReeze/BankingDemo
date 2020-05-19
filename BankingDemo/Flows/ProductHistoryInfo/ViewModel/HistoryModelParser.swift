//
//  HistoryModelParser.swift
//  BankingDemo
//

import UIKit

private extension OperationsPayload {

    enum TranfserType: String {
        case debit = "Debit"
        case credit = "Credit"

        var sign: String {
            switch self {
            case .credit:
                return "+"
            case .debit:
                return "-"
            }
        }
    }

    enum Currency: String {
        case rub = "RUB"

        var sign: String {
            return "₽"
        }
    }

    var sumString: String {
        let value = amount.value.formattedDoubleValue
        let withCurrency = (Currency(rawValue: amount.currency.name)?.sign ~> { "\(value) \($0)" }) ?? value
        guard let type = TranfserType(rawValue: type) else {
            return withCurrency
        }
        return type.sign + withCurrency
    }

}

extension Double {

    var formattedDoubleValue: String {
        let nf = NumberFormatter()
        nf.locale = NSLocale.current
        let decimalSeparator = nf.decimalSeparator ?? "."
        let floatString = String(format: "%.2f", self)
        return floatString.replacingOccurrences(of: ".", with: decimalSeparator)
    }

}

final class HistoryModelsParser {

    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()

    private func randomHexColorCode() -> String {
        let a = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f"]
        let randomValue: ([String]) -> String = {
            return $0[Int.random(in: 0..<$0.count)]
        }
        return (0...5).map { _ in randomValue(a) }.joined()
    }

    func sortAndParseData(_ historyItems: HistoryEntity) -> [HistorySection] {
        var dict = [String: [HistoryCellModel]]()

        for item in historyItems.payload.operations.payload {
            let name = [item.brand?.name, item.merchant?.name].firstActualValue()
            let initials = (name.first ~> String.init) ?? "UN"
            let url = "https://dummyimage.com/80X80/\(item.brand?.baseColor ?? randomHexColorCode())/\(item.brand?.baseTextColor ?? "ffffff")&text=\(initials)"

            let model = HistoryCellModel(placeholder: UIImage(),
                                         iconUrl: url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                                         mainTitle: name,
                                         subTitle: item.category.name,
                                         sumString: item.sumString,
                                         category: "Tinkoff Black")
            let itemDate = Date(timeIntervalSince1970: TimeInterval(item.debitingTime?.milliseconds ?? item.operationTime.milliseconds) / 1000.0)
            let dictKey = formatter.string(from: itemDate)
            if var array = dict[dictKey] {
                array.append(model)
                dict[dictKey] = array
            } else {
                dict[dictKey] = [model]
            }
        }

        var historySections: [HistorySection] = []
        for (dateString, historyArray) in dict {
            guard let date = formatter.date(from: dateString) else {
                continue
            }
            let historySection = HistorySection(itemsDate: date, items: historyArray)
            historySections.append(historySection)
        }
        historySections = historySections.sorted(by: { $0.itemsDate.compare($1.itemsDate) == .orderedDescending })
        return historySections
    }

}

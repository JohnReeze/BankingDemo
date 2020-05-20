//
//  HistorySection.swift
//  BankingDemo
//

import Foundation

struct HistorySection {

    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM"
        formatter.locale = Locale(identifier: "ru")
        return formatter
    }()
    private(set) var itemsDate: Date
    private(set) var items: [HistoryCellModel]

    init(itemsDate: Date, items: [HistoryCellModel]) {
        self.itemsDate = itemsDate
        self.items = items
    }

    var title: String {
        if Calendar.current.isDateInToday(itemsDate) {
            return L10n.Date.today
        }
        if Calendar.current.isDateInYesterday(itemsDate) {
            return L10n.Date.yestarday
        }

        return formatter.string(from: itemsDate)
    }
}

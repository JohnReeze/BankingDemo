//
//  ProductHistoryInfoOutput.swift
//  ZenitOnline
//

protocol ProductHistoryInfoOutput: class {
    func didUpdate(models: [(type: ExpenseType, part: Double)])
}

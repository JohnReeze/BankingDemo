//
//  ProductHistoryInfoInput.swift
//  BankingDemo
//

protocol ProductHistoryInfoInput: class {
    func forceUpdate()
    func update(for productId: String)
}

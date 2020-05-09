//
//  Array.swift
//  BankingDemo
//

public extension Array {

    /// Out of range checker
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }

}

public extension Array where Element == String? {

    /// Method returns first not empty value or ""
    func firstActualValue() -> String {
        return compactMap { $0 }.first { !$0.isEmpty } ?? ""
    }

}

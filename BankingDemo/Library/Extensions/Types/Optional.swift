//
//  Optional.swift
//  BankingDemo
//

public extension Optional {

    var isNil: Bool {
        if case .none = self { return true }
        return false
    }

    var isSome: Bool {
        if case .some = self { return true }
        return false
    }

}

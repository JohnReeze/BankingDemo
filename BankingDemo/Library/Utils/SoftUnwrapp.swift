//
//  SoftUnwrapp.swift
//  BankingDemo
//

infix operator ~>

func ~><A: Any>(left: A?, right: ((A) -> Void)?) {
    guard let left = left else { return }
    right?(left)
}

@discardableResult
func ~><A: Any, B: Any>(left: A?, right: (A) -> B?) -> B? {
    guard let left = left else { return nil }
    return right(left)
}

@discardableResult
func ~><A: Any, B: Any>(left: A?, right: (A) -> B) -> B? {
    guard let left = left else { return nil }
    return right(left)
}

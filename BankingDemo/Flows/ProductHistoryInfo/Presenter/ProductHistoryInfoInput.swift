//
//  ProductHistoryInfoInput.swift
//  ZenitOnline
//

protocol ProductHistoryInfoInput: class {
    func forceUpdate()
    func update(for productId: String)
}

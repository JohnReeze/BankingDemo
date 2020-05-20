//
//  ProductDetailedInfoInput.swift
//  BankingDemo
//

protocol ProductDetailedInfoInput: class {
    func didChangedState(_ newState: ProductStateViewModel)
    func configure(with models: [ProductViewModel])
    func forceUpdate()
}

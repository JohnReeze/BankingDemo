//
//  ProductMainInfoViewInput.swift
//  BankingDemo
//

protocol ProductMainInfoViewInput: class {
    func setupInitialState()
    func configure(with models: [ProductViewModel])
}

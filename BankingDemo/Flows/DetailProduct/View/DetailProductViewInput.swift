//
//  DetailProductViewInput.swift
//  BankingDemo
//

protocol DetailProductViewInput: class {
    func setupInitialState()
    func configure(with model: DetailProductNameModel)
}

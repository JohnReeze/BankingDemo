//
//  ProductDetailedInfoViewInput.swift
//  BankingDemo
//

protocol ProductDetailedInfoViewInput: class {
    func setStateChangeProgress(_ progress: Double)
    func setupInitialState()
    func configure(model: ExpensesModel)
}

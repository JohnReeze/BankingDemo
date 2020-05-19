//
//  ProductDetailedInfoViewInput.swift
//  ZenitOnline
//

protocol ProductDetailedInfoViewInput: class {
    func setStateChangeProgress(_ progress: Double)
    func setupInitialState()
    func configure(model: ExpensesModel)
}

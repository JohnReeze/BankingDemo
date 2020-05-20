//
//  ProductDetailedInfoViewInput.swift
//  BankingDemo
//

protocol ProductDetailedInfoViewInput: class {
    func setupInitialState()
    func configure(model: ExpensesModel)
    func setExpensesOption(_ isEnabled: Bool)
    func setProgress(_ progress: Double, hadExpenses: Bool, willHaveExpenses: Bool)
}

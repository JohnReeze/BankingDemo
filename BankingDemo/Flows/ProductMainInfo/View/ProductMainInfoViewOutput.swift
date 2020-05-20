//
//  ProductMainInfoViewOutput.swift
//  BankingDemo
//

protocol ProductMainInfoViewOutput: class {
    func viewLoaded()
    func didSelectAction(_ action: ProductFastActionType)
    func didStateChanged(_ newState: ProductStateViewModel)
}

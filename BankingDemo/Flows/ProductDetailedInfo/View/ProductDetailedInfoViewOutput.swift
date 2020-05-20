//
//  ProductDetailedInfoViewOutput.swift
//  BankingDemo
//

protocol ProductDetailedInfoViewOutput: class {
    func viewLoaded()
    func didChangeState(newState: Int)
}

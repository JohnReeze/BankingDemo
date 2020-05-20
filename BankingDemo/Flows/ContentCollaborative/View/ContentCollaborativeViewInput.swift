//
//  ContentCollaborativeViewInput.swift
//  BankingDemo
//

protocol ContentCollaborativeViewInput: class {
    func setupInitialState()
    func configure(viewModel: TableViewModel)
}

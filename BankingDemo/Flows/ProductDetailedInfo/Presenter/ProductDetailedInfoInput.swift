//
//  ProductDetailedInfoInput.swift
//  ZenitOnline
//

protocol ProductDetailedInfoInput: class {
    func didChangedState(_ newState: ProductStateViewModel)
    func configure(with model: [String], selectedIndex: Int)
    func forceUpdate()
}

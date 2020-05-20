//
//  ProductService.swift
//  BankingDemo
//

protocol ProductService {
    func loadProducts(completion: Closure<Result<[ProductViewModel], Error>>)
}

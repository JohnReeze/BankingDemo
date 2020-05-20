//
//  HistoryService.swift
//  BankingDemo
//

protocol HistoryService {
    func loadHistory(productId: String,
                     offset: Int,
                     limit: Int,
                     completion: @escaping Closure<Result<HistoryEntity, Error>>)
}

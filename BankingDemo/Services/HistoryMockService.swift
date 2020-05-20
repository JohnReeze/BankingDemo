//
//  HistoryMockService.swift
//  BankingDemo
//

import Foundation

final class HistoryMockService: HistoryService {

    enum HistoryMockError: Error {
        case cantLoadMock
        case cantParseMock
    }

    func loadHistory(productId: String, offset: Int, limit: Int, completion: @escaping Closure<Result<HistoryEntity, Error>>) {
        DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 1...4)) {
            DispatchQueue.global(qos: .userInteractive).async {
                guard let fileUrl = Bundle.main.url(forResource: "HistoryMock", withExtension: "json") else {
                    DispatchQueue.main.async { completion(.failure(HistoryMockError.cantLoadMock)) }
                    return
                }

                do {
                    let jsonMock = try Data(contentsOf: fileUrl)
                    let jsonDecoder = JSONDecoder()
                    let mockResponse = try jsonDecoder.decode(HistoryEntity.self, from: jsonMock)
                    DispatchQueue.main.async { completion(.success(mockResponse)) }
                } catch {
                    DispatchQueue.main.async { completion(.failure(error)) }
                }
            }
        }
    }
}

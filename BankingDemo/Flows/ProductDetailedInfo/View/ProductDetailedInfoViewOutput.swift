//
//  ProductDetailedInfoViewOutput.swift
//  BankingDemo
//
//  Created by Mikhail Monakov on 04/02/2020.
//  Copyright © 2020 Surf. All rights reserved.
//

protocol ProductDetailedInfoViewOutput: class {
    func viewLoaded()
    func didChangeState(newState: Int)
}

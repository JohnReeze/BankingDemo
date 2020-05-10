//
//  ProductMainInfoOutput.swift
//  ZenitOnline
//
//  Created by Mikhail Monakov on 27/01/2020.
//  Copyright © 2020 Surf. All rights reserved.
//

protocol ProductMainInfoOutput: class {
    func didStateChanged(_ newState: ProductStateViewModel)
    func didSelectCard(at index: Int?)
    func didChangedBalance(_ isHidden: Bool)
}

//
//  ProductMainInfoViewOutput.swift
//  ZenitOnline
//
//  Created by Mikhail Monakov on 27/01/2020.
//  Copyright © 2020 Surf. All rights reserved.
//

protocol ProductMainInfoViewOutput: class {
    func viewLoaded()
    func didSelectAction(_ action: ProductFastActionType)
    func didSelectCard(at index: Int?)
    func didStateChanged(_ newState: ProductStateViewModel)
    func didSelectHideOption()
}

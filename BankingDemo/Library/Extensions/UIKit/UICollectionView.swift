//
//  UICollectionView.swift
//  BankingDemo
//

import UIKit

extension UICollectionView {

    func registerNib(_ cellType: UICollectionViewCell.Type) {
        register(UINib(nibName: cellType.nameOfClass, bundle: Bundle(for: cellType.self)), forCellWithReuseIdentifier: cellType.nameOfClass)
    }

    func dequeueCell<Cell: UICollectionViewCell>(_ type: Cell.Type = Cell.self, for indexPath: IndexPath) -> Cell? {
        return self.dequeueReusableCell(withReuseIdentifier: type.nameOfClass, for: indexPath) as? Cell
    }

    func dequeueReusableCell<Cell: UICollectionViewCell>(_ type: Cell.Type = Cell.self, indexPath: IndexPath) -> Cell? {
        return dequeueReusableCell(withReuseIdentifier: type.nameOfClass, for: indexPath) as? Cell
    }

}

//
//  UITableView.swift
//  BankingDemo
//

import UIKit

extension UITableView {

    func registerNib(_ cellType: UITableViewCell.Type) {
        self.register(UINib(nibName: cellType.nameOfClass, bundle: Bundle(for: cellType.self)), forCellReuseIdentifier: cellType.nameOfClass)
    }

    func dequeueReusableCell<Cell: UITableViewCell>(`type`: Cell.Type = Cell.self) -> Cell? {
        return self.dequeueReusableCell(withIdentifier: Cell.nameOfClass) as? Cell
    }

    func dequeueReusableCell<Cell: UITableViewCell>(_ type: Cell.Type = Cell.self, indexPath: IndexPath) -> Cell? {
        return dequeueReusableCell(withIdentifier: Cell.nameOfClass, for: indexPath) as? Cell
    }

}

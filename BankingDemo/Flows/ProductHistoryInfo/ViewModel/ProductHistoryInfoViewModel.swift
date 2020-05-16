//
//  ProductHistoryInfoViewModel.swift
//
//

import UIKit

final class ProductHistoryInfoViewModel: NSObject, TableViewModel {

    func configure(_ tableView: UITableView) {
        tableView.dataSource = self
    }

}

extension ProductHistoryInfoViewModel: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Test Code"
        return cell
    }

}


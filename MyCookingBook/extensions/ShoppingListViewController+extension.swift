//
//  ShoppingListViewController+extension.swift
//  MyCookingBook
//
//  Created by алексей ганзицкий on 19.07.2023.
//

import UIKit

extension ShoppingListViewController:  UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        
        if indexPath.row == numberOfRows {
            // Инициализируем ячейку с кнопкой
            guard let myCell = tableView.dequeueReusableCell(withIdentifier: "MyCustomCell", for: indexPath) as? ShoppingListTableViewCell else {
                return UITableViewCell()
            }
            myCell.buttonToAddNewCell.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
            return myCell
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            let item = shoppingList[indexPath.row]
            let isChecked = checkedItems[indexPath.row]
            
            cell.textLabel?.text = "\(item.type)      \(item.measuresOfMeasurement)"
            cell.accessoryType = isChecked ? .checkmark : .none
        }
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row != numberOfRows {
            checkedItems[indexPath.row] = !checkedItems[indexPath.row]
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}

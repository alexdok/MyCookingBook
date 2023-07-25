//
//  ShoppingListViewController+extension.swift
//  MyCookingBook
//
//  Created by алексей ганзицкий on 19.07.2023.
//

import UIKit

extension ShoppingListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        
        if indexPath.row == viewModel.numberOfRows {
            // Инициализируем ячейку с кнопкой
            guard let myCell = tableView.dequeueReusableCell(withIdentifier: "MyCustomCell", for: indexPath) as? ShoppingListTableViewCell else { return UITableViewCell() }
            myCell.buttonToAddNewCell.addTarget(self, action: #selector(addNewCellButtonTapped), for: .touchUpInside)
            return myCell
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            let item = viewModel.shoppingList[indexPath.row]
            let isChecked = viewModel.checkedItems[indexPath.row]
            
            cell.textLabel?.text = configure(with: item)
            cell.accessoryType = isChecked ? .checkmark : .none
        }
        return cell
    }
    
    func configure(with item: Ingridient) -> String {
        let type = "\(item.type)"
        let measure = item.measuresOfMeasurement
        
        switch measure {
        case .weight(let value, let unit):
            return type + "  " + "\(value)" + " " + "\(unit)"
        case .volume(let value, let unit):
            return type + "  " + "\(value)" + " " + "\(unit)"
        case .pieces(let value, let unit):
            return type + "  " + "\(value)" + " " + "\(unit)"
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.shoppingList.remove(at: indexPath.row)
            viewModel.checkedItems.remove(at: indexPath.row)
            viewModel.saveState()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row != viewModel.numberOfRows {
            viewModel.toggleItemCheckedStatus(at: indexPath.row)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}


//
//  ShoppingListViewController+extension.swift
//  MyCookingBook
//
//  Created by алексей ганзицкий on 19.07.2023.
//

import UIKit

    
    // MARK: - UITableViewDataSource
    
    extension ShoppingListViewController: UITableViewDataSource, UITableViewDelegate {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return viewModel.numberOfRows + 1
        }
        
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell: UITableViewCell
        
                if indexPath.row == viewModel.numberOfRows {
                    // Инициализируем ячейку с кнопкой
                    guard let myCell = tableView.dequeueReusableCell(withIdentifier: "MyCustomCell", for: indexPath) as? ShoppingListTableViewCell else {
                        return UITableViewCell()
                    }
                    myCell.buttonToAddNewCell.addTarget(self, action: #selector(addNewCellButtonTapped), for: .touchUpInside)
                    return myCell
                } else {
                    cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                    let item = viewModel.shoppingList[indexPath.row]
                    let isChecked = viewModel.checkedItems[indexPath.row]
        
                    cell.textLabel?.text = "\(item.type)      \(item.measuresOfMeasurement)"
                    cell.accessoryType = isChecked ? .checkmark : .none
                }
                return cell
            }

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            
            if indexPath.row != viewModel.numberOfRows {
                viewModel.toggleItemCheckedStatus(at: indexPath.row)
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
    }


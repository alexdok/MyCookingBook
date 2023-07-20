import UIKit

enum Units {
    case kilograms
    case liters
    case pieces
}

class ShoppingListViewController: UIViewController {
    
    let tableView = UITableView()
    let viewModel = ShoppingListViewModel()
    var selectedUnit: Units = .kilograms
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(ShoppingListTableViewCell.self, forCellReuseIdentifier: "MyCustomCell")
        view.addSubview(tableView)
        
        viewModel.addNewItem(name: "яблоко", quantity: 5)
        viewModel.addNewItem(name: "греча", quantity: 0.5)
        viewModel.addNewItem(name: "молоко", quantity: 1)
        viewModel.addNewItem(name: "fanta", quantity: 1)
    }
    
    @objc func addNewCellButtonTapped() {
        createAlertController()
    }
    
    func createAlertController() {
        let alert = UIAlertController(title: "Add New Item to Shopping List", message: "Add name and quantity", preferredStyle: .alert)
        
        // Создаем текстовое поле для ввода названия товара
        alert.addTextField { textField in
            textField.placeholder = "Enter item name"
        }
        
        // Создаем текстовое поле для ввода количества товара
        alert.addTextField { textField in
            textField.placeholder = "Enter quantity"
            textField.keyboardType = .decimalPad
            
            // Добавляем переключатель между единицами измерения
            let unitsSegmentedControl = UISegmentedControl(items: ["kg", "L", "pcs"])
            unitsSegmentedControl.selectedSegmentIndex = 0 // Устанавливаем выбранной по умолчанию первую единицу измерения (кг)
            textField.rightView = unitsSegmentedControl
            textField.rightViewMode = .always
            
            // Обработчик события при изменении значения переключателя
            unitsSegmentedControl.addTarget(self, action: #selector(self.unitChanged(_:)), for: .valueChanged)
        }
        
        // Добавляем кнопку "Сохранить"
        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self, weak alert] _ in
            // Получаем введенные значения из текстовых полей
            if let nameTextField = alert?.textFields?.first, let quantityTextField = alert?.textFields?.last {
                let itemName = nameTextField.text ?? ""
                let itemQuantity = Double(quantityTextField.text ?? "0") ?? 0
                
                // Вызываем функцию для сохранения товара с введенными значениями и выбранной единицей измерения
                guard let self = self else { return }
                viewModel.saveItem(name: itemName, quantity: itemQuantity, unit: self.selectedUnit)
                tableView.reloadData()
            }
        }
        
        // Добавляем кнопку "Отмена"
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        // Добавляем кнопки в UIAlertController
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        // Показываем UIAlertController на экране
        present(alert, animated: true, completion: nil)
    }
    
    @objc func unitChanged(_ sender: UISegmentedControl) {
        // Обработчик события при изменении значения переключателя
        switch sender.selectedSegmentIndex {
        case 0:
            selectedUnit = .kilograms
        case 1:
            selectedUnit = .liters
        case 2:
            selectedUnit = .pieces
        default:
            break
        }
    }
}

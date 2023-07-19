import UIKit

enum Units {
    case kilograms
    case liters
    case things
}

class ShoppingListViewController: UIViewController {
    var selectedUnit: Units = .kilograms
    var shoppingList: [Ingridient] = []
    var checkedItems: [Bool] = [false,false,false,false]
     var numberOfRows = 0
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shoppingList.append(createNewitem(name: "яблоко", quantity: 5, units: .things))
        shoppingList.append(createNewitem(name: "греча", quantity: 0.5, units: .kilograms))
        shoppingList.append(createNewitem(name: "молоко", quantity: 1, units: .liters))
        shoppingList.append(createNewitem(name: "fanta", quantity: 1, units: .things))

        numberOfRows = shoppingList.count
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(ShoppingListTableViewCell.self, forCellReuseIdentifier: "MyCustomCell")
        view.addSubview(tableView)
    }
    
    private func createNewitem(name: String, quantity: Double, units: Units) -> Ingridient {
        let newIngridient = {
            switch units {
            case .kilograms:
                return Ingridient(type: name, measuresOfMeasurement: .init(weight: quantity))
            case .liters:
                return Ingridient(type: name, measuresOfMeasurement: .init(volume: quantity))
            case .things:
                return Ingridient(type: name, measuresOfMeasurement: .init(amount: quantity))
            }
        }()
        return newIngridient
    }
    
    @objc func addButtonTapped() {
        // Действие при нажатии кнопки "Добавить"
        // Увеличиваем количество строк
        shoppingList.append(Ingridient(type: "test", measuresOfMeasurement: .init(volume: 5)))
        checkedItems.append(false)
        numberOfRows += 1
        createAlertController()
        // Обновляем таблицу
        tableView.reloadData()
    }
   
    
      func createAlertController() {
          let alert = UIAlertController(title: "Add New Item to Shopping List", message: "Add name and quantity", preferredStyle: .alert)
          
          // Создаем текстовое поле для ввода названия товара
          alert.addTextField { textField in
              textField.placeholder = "Enter item name"
          }
          
          // Создаем текстовое поле для ввода количества товара
          alert.addTextField { [weak self] textField in
              textField.placeholder = "Enter quantity"
              textField.keyboardType = .decimalPad
              
              // Добавляем переключатель между единицами измерения
              let unitsSegmentedControl = UISegmentedControl(items: ["kg", "L", "pcs"])
              unitsSegmentedControl.selectedSegmentIndex = 0 // Устанавливаем выбранной по умолчанию первую единицу измерения (кг)
              textField.rightView = unitsSegmentedControl
              textField.rightViewMode = .always
              
              // Обработчик события при изменении значения переключателя
              unitsSegmentedControl.addTarget(self, action: #selector(self?.unitChanged(_:)), for: .valueChanged)
          }
          
          // Добавляем кнопку "Сохранить"
          let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self, weak alert] _ in
              // Получаем введенные значения из текстовых полей
              if let nameTextField = alert?.textFields?.first, let quantityTextField = alert?.textFields?.last {
                  let itemName = nameTextField.text ?? ""
                  let itemQuantity = Int(quantityTextField.text ?? "0") ?? 0
                  
                  // Вызываем функцию для сохранения товара с введенными значениями и выбранной единицей измерения
                  self?.saveItem(name: itemName, quantity: itemQuantity, unit: self?.selectedUnit)
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
              selectedUnit = .things
          default:
              break
          }
      }
      
      func saveItem(name: String, quantity: Int, unit: Units?) {
          // Ваш код для сохранения товара
          // Здесь можно выполнить нужные вам действия с введенными значениями и выбранной единицей измерения
          if let selectedUnit = unit {
              switch selectedUnit {
              case .kilograms:
                  // Добавить обработку для единицы измерения килограмм
                  print("\(quantity) kg of \(name)")
              case .liters:
                  // Добавить обработку для единицы измерения литры
                  print("\(quantity) L of \(name)")
              case .things:
                  // Добавить обработку для единицы измерения штуки
                  print("\(quantity) pcs of \(name)")
              }
          }
      }
}


import UIKit

enum Units {
    case kilograms
    case liters
    case things
}

class ShoppingListViewController: UIViewController {

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

        // Обновляем таблицу
        tableView.reloadData()
    }
   
}


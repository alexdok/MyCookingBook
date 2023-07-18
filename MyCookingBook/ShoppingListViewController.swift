import UIKit

enum Units {
    case kilograms
    case liters
    case things
}

class ShoppingListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

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
        tableView.register(MyCustomCell.self, forCellReuseIdentifier: "MyCustomCell")
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
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        
        if indexPath.row == numberOfRows {
            // Инициализируем ячейку с кнопкой
            guard let myCell = tableView.dequeueReusableCell(withIdentifier: "MyCustomCell", for: indexPath) as? MyCustomCell else {
                return UITableViewCell()
            }
            myCell.buttonToAddNewCell.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
            return myCell
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            let item = shoppingList[indexPath.row]
            let isChecked = checkedItems[indexPath.row]
            
            cell.textLabel?.text = item.type
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

class MyCustomCell: UITableViewCell {
    
    var buttonToAddNewCell: UIButton!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         buttonToAddNewCell = createButton(title: "добавить", color: .green)
         applyButtonStyle(buttonToAddNewCell)
         addConstraintsButton()
     }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        textLabel?.text = nil
        accessoryType = .none
    }
    
     func createButton(title: String, color: UIColor) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.backgroundColor = color
        button.layer.cornerRadius = 10
         applyButtonStyle(button)
        return button
    }
    
    private func applyButtonStyle(_ button: UIButton) {
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.textColor = .black
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    }
    
     func addConstraintsButton() {
        contentView.addSubview(buttonToAddNewCell)
        buttonToAddNewCell.translatesAutoresizingMaskIntoConstraints = false
      
        NSLayoutConstraint.activate([
            buttonToAddNewCell.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            buttonToAddNewCell.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            buttonToAddNewCell.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            buttonToAddNewCell.heightAnchor.constraint(equalTo: contentView.heightAnchor),
        ])
    }
}

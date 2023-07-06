import UIKit

class ShoppingListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var shoppingList: [String] = ["Яблоки", "Молоко", "Хлеб", "Яйца"]
    var checkedItems: [Bool] = [false, false, false, false]
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = shoppingList[indexPath.row]
        let isChecked = checkedItems[indexPath.row]
        
        cell.textLabel?.text = item
        cell.accessoryType = isChecked ? .checkmark : .none
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        checkedItems[indexPath.row] = !checkedItems[indexPath.row]
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

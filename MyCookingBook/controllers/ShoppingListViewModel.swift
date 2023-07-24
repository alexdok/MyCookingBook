import Foundation

class ShoppingListViewModel {
    
    var selectedUnit: Units = .kilograms
    var shoppingList: [Ingridient] = []
    var checkedItems: [Bool] = []
    
    var numberOfRows: Int {
        return shoppingList.count
    }
    
    func createNewItem(name: String, quantity: Double, units: Units) -> Ingridient {
        let newIngridient: Ingridient
        switch units {
        case .kilograms:
            newIngridient = Ingridient(type: name, measuresOfMeasurement: .init(weight: quantity))
        case .liters:
            newIngridient = Ingridient(type: name, measuresOfMeasurement: .init(volume: quantity))
        case .pieces:
            newIngridient = Ingridient(type: name, measuresOfMeasurement: .init(amount: quantity))
        }
        return newIngridient
    }
    
    func saveItem(name: String, quantity: Double, unit: Units) {
        let newItem = createNewItem(name: name, quantity: quantity, units: unit)
        shoppingList.append(newItem)
        checkedItems.append(false)
    }
    
    func toggleItemCheckedStatus(at index: Int) {
        guard index >= 0 && index < checkedItems.count else { return }
        checkedItems[index].toggle()
    }
  
    func saveState() {
        do {
            let encoder = JSONEncoder()
            let shoppingListData = try encoder.encode(shoppingList)
            UserDefaults.standard.set(shoppingListData, forKey: "shoppingList")
            
            let checkedItemsData = try encoder.encode(checkedItems)
            UserDefaults.standard.set(checkedItemsData, forKey: "checkedItems")
        } catch {
            print("Ошибка при кодировании данных: \(error)")
        }
    }

    func loadValuesToShoppingList() {
        do {
            if let shoppingListData = UserDefaults.standard.data(forKey: "shoppingList") {
                let decoder = JSONDecoder()
                shoppingList = try decoder.decode([Ingridient].self, from: shoppingListData)
            } else {
                shoppingList = []
            }
            
            if let checkedItemsData = UserDefaults.standard.data(forKey: "checkedItems") {
                let decoder = JSONDecoder()
                checkedItems = try decoder.decode([Bool].self, from: checkedItemsData)
            } else {
                checkedItems = []
            }
        } catch {
            print("Ошибка при декодировании данных: \(error)")
        }
    }
}

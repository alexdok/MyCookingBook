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

    func addNewItem(name: String, quantity: Double) {
        let newItem = createNewItem(name: name, quantity: quantity, units: selectedUnit)
        shoppingList.append(newItem)
        checkedItems.append(false)
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
}

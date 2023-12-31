//
//  NewRecipeViewModel.swift
//  MyCookingBook
//
//  Created by алексей ганзицкий on 28.07.2023.
//

import UIKit
import CoreData

class NewRecipeViewModel {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var nameRecipe = ""
    var textRecipe = ""
    var imageRecipe: UIImage?
    var recipe: Bindable<Recipe>?
    
    func createNewRecipeInDataBase(image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            print("Ошибка при конвертировании изображения в данные")
            return
        }
       let newRecipe = Recipe(context: context)
        newRecipe.name = nameRecipe
        newRecipe.text = textRecipe
        newRecipe.imageFood = imageData
        do {
            try context.save()
        } catch {
            print("Ошибка при сохранении: \(error)")
        }
    }
    
    // заглушка чтобы не плодить базу
    func loadRecipe() {
        let fetchRequest: NSFetchRequest<Recipe> = Recipe.fetchRequest()

        do {
            let currentrecipe = try context.fetch(fetchRequest)
           print( currentrecipe.count)
            var value = ""
            for recipe in currentrecipe {
                
                if recipe.name != value {
                    value = recipe.name ?? ""
                    nameRecipe = recipe.name ?? ""
                    textRecipe = recipe.text ?? ""
                    if let data = recipe.imageFood {
                        imageRecipe = UIImage(data: data)
                    }
                } else {
                    deleteRecipe(name: recipe.name ?? "")
                }
            }
        } catch {
            print("Ошибка при запросе данных: \(error)")
        }
    }
    
    func deleteRecipe(name: String) {
        let fetchRequest: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        do {
            let fetchedPersons = try context.fetch(fetchRequest)
            if let personToDelete = fetchedPersons.first {
                context.delete(personToDelete)
                try context.save()
                print("Объект успешно удален из базы данных")
            } else {
                print("Объект с именем \(name) не найден в базе данных")
            }
        } catch {
            print("Ошибка при удалении объекта из базы данных: \(error)")
        }
    }
    
}

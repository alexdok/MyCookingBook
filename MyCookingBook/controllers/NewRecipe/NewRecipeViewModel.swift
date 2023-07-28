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
    
    func loadRecipe() {
        let fetchRequest: NSFetchRequest<Recipe> = Recipe.fetchRequest()

        do {
            let currentrecipe = try context.fetch(fetchRequest)
            for recipe in currentrecipe {
                nameRecipe = recipe.name ?? ""
                textRecipe = recipe.text ?? ""
                if let data = recipe.imageFood {
                    imageRecipe = UIImage(data: data)
                }
            }
        } catch {
            print("Ошибка при запросе данных: \(error)")
        }
    }
}

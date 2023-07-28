//
//  AppDelegate.swift
//  NoStoryboard
//
//  Created by алексей ганзицкий on 06.02.2023.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Core Data stack

      lazy var persistentContainer: NSPersistentContainer = {
          let container = NSPersistentContainer(name: "RecipeModel")
          container.loadPersistentStores(completionHandler: { (_, error) in
              if let error = error as NSError? {
                  fatalError("Ошибка при загрузке хранилища данных: \(error), \(error.userInfo)")
              }
          })
          return container
      }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

    }
}


//
//  MainViewController.swift
//  testTUTU
//
//  Created by алексей ганзицкий on 05.07.2023.
//


import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Создаем градиентный фон
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.orange.cgColor, UIColor.purple.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        // Создаем кнопки
        let buttonSize = CGSize(width: 200, height: 50)
        
        let button1 = createButton(title: "Новый рецепт", color: .systemBlue)
        button1.addTarget(self, action: #selector(goToNewRecipe), for: .touchUpInside)
        let button2 = createButton(title: "Смотреть записи", color: .systemBlue)
        button2.addTarget(self, action: #selector(goToMyCoocingBook), for: .touchUpInside)
        let button3 = createButton(title: "Найти что-то новое", color: .systemBlue)
        
        view.addSubview(button1)
        view.addSubview(button2)
        view.addSubview(button3)
        
        button1.translatesAutoresizingMaskIntoConstraints = false
        button2.translatesAutoresizingMaskIntoConstraints = false
        button3.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button1.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            button1.widthAnchor.constraint(equalToConstant: buttonSize.width),
            button1.heightAnchor.constraint(equalToConstant: buttonSize.height),
            
            button2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button2.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button2.widthAnchor.constraint(equalToConstant: buttonSize.width),
            button2.heightAnchor.constraint(equalToConstant: buttonSize.height),
            
            button3.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button3.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100),
            button3.widthAnchor.constraint(equalToConstant: buttonSize.width),
            button3.heightAnchor.constraint(equalToConstant: buttonSize.height)
        ])
        
        applyButtonStyle(button1)
        applyButtonStyle(button2)
        applyButtonStyle(button3)
    }
    
    private func createButton(title: String, color: UIColor) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.backgroundColor = color
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.shadowOpacity = 0.5
        return button
    }
    
    private func applyButtonStyle(_ button: UIButton) {
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    }
    
    @objc func goToMyCoocingBook(sender: UIButton!) {
        let cookingBookViewController = TableViewController()
        navigationController?.pushViewController(cookingBookViewController, animated: true)
    }
    
    @objc func goToNewRecipe(sender: UIButton!) {
        let newRecipeVC = NewRecipeViewController()
        navigationController?.pushViewController(newRecipeVC, animated: true)
    }
}	

//import UIKit
//
//class MainViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Создаем градиентный фон
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = view.bounds
//        gradientLayer.colors = [UIColor.orange.cgColor, UIColor.purple.cgColor]
//        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
//        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
//        view.layer.insertSublayer(gradientLayer, at: 0)
//
//        // Создаем кнопки
//        let buttonSize = CGSize(width: 200, height: 50)
//
//        let button1 = createButton(title: "Новый рецепт", color: .systemBlue)
//        button1.addTarget(self, action: #selector(goToNewRecipe), for: .touchUpInside)
//        let button2 = createButton(title: "Смотреть записи", color: .systemBlue)
//        button2.addTarget(self, action: #selector(goToMyCoocingBook), for: .touchUpInside)
//        let button3 = createButton(title: "Найти что-то новое", color: .systemBlue)
//
//        button1.frame = CGRect(x: view.center.x - buttonSize.width / 2, y: view.center.y - 100, width: buttonSize.width, height: buttonSize.height)
//        button2.frame = CGRect(x: view.center.x - buttonSize.width / 2, y: view.center.y, width: buttonSize.width, height: buttonSize.height)
//        button3.frame = CGRect(x: view.center.x - buttonSize.width / 2, y: view.center.y + 100, width: buttonSize.width, height: buttonSize.height)
//
//        applyButtonStyle(button1)
//        applyButtonStyle(button2)
//        applyButtonStyle(button3)
//
//        view.addSubview(button1)
//        view.addSubview(button2)
//        view.addSubview(button3)
//    }
//
//    private func createButton(title: String, color: UIColor) -> UIButton {
//        let button = UIButton(type: .system)
//        button.setTitle(title, for: .normal)
//        button.backgroundColor = color
//        button.layer.cornerRadius = 10
//        button.addShadow()
//        return button
//    }
//
//    private func applyButtonStyle(_ button: UIButton) {
//        button.setTitleColor(.white, for: .normal)
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
//    }
//
//    @objc func goToMyCoocingBook(sender: UIButton!) {
//        toNewController(viewController: TableViewController())
//       }
//    @objc func goToNewRecipe(sender: UIButton!) {
//        toNewController(viewController: NewRecipeViewController())
//       }
//
//    func toNewController(viewController: UIViewController) {
//        navigationController?.pushViewController(viewController, animated: true)
//    }
//}

extension UIView {
    func addShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowOpacity = 0.8
    }
}

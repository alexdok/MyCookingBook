import UIKit

class MainViewController: UIViewController {
    
    let buttonSize = CGSize(width: 200, height: 50)
    var buttonsArray: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createBackgroundColor()
        createManualButtons()
    }
    
    private func createManualButtons() {
        // Создаем кнопки
        let button1 = createButton(title: "Новый рецепт", color: .systemBlue)
        button1.addTarget(self, action: #selector(goToNewRecipe), for: .touchUpInside)
        let button2 = createButton(title: "Смотреть записи", color: .systemBlue)
        button2.addTarget(self, action: #selector(goToMyCoocingBook), for: .touchUpInside)
        let button3 = createButton(title: "Найти что-то новое", color: .systemBlue)
        button3.addTarget(self, action: #selector(goToRandomRecipe), for: .touchUpInside)
        
        buttonsArray.forEach { button in
            view.addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            applyButtonStyle(button)
        }
        
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
    }
    
    private func createBackgroundColor() {
        // Создаем градиентный фон
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.orange.cgColor, UIColor.purple.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func createButton(title: String, color: UIColor) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.backgroundColor = color
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.shadowOpacity = 0.5
        buttonsArray.append(button)
        return button
    }
    
    private func applyButtonStyle(_ button: UIButton) {
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    }
    
    @objc func goToMyCoocingBook(sender: UIButton!) {
        toNewViewController(viewController: TableViewController())
    }
    
    @objc func goToNewRecipe(sender: UIButton!) {
        toNewViewController(viewController:  NewRecipeViewController())
    }
    
    @objc func goToRandomRecipe(sender: UIButton!) {
        let webViewController = WebViewController()
        toNewViewController(viewController: webViewController)
    }
    
    func toNewViewController(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}


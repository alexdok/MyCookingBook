import UIKit

class NewRecipeViewController: UIViewController {
    
    var imageView: UIImageView!
    var ingredientsButton: UIButton!
    var textView: UITextView!
    var originalTextViewFrame: CGRect!
    var expandButton: UIButton!
    var nameTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
        setupBackgroundColor()
        addRecognizerTapToImage()
        addExpandButton()
        // Добавление наблюдателя для отслеживания изменений в высоте клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.expandButtonTapped()
        }
    }

    private func createUI() {
        // Создание UIImageView
        let screenHeight = UIScreen.main.bounds.height
        let thirdHeight = screenHeight / 3
        imageView = UIImageView(frame: CGRect(x: 0, y: 60 , width: view.frame.width, height: thirdHeight))
        imageView.backgroundColor = .green
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOffset = CGSize(width: 2, height: 2)
        imageView.layer.shadowOpacity = 0.5
        view.addSubview(imageView)
        
        // Создание UIButton
        let buttonY = imageView.frame.maxY
        let buttonHeight: CGFloat = 50
        ingredientsButton = UIButton(frame: CGRect(x: 0, y: buttonY, width: view.frame.width, height: buttonHeight))
        ingredientsButton.setTitle("Ингредиенты", for: .normal)
        ingredientsButton.addTarget(self, action: #selector(goToShoppingList), for: .touchUpInside)
        view.addSubview(ingredientsButton)
        
        // создаем UITextField для названия
        let nameTFY = buttonY  + buttonHeight
        let nameTFHeight: CGFloat = 50
        nameTF = UITextField(frame: CGRect(x: 0, y: nameTFY, width: view.frame.width, height: nameTFHeight))
        nameTF.textAlignment = .center
        nameTF.placeholder = "название блюда"
        nameTF.backgroundColor = UIColor(red: 1, green: 1, blue: 0.9, alpha: 1)
        nameTF.borderStyle = .line
        nameTF.delegate = self
        view.addSubview(nameTF)
        
        // Создание UITextView
        let textViewY = nameTF.frame.maxY
        let textViewHeight = screenHeight - thirdHeight - buttonHeight - nameTFHeight
        textView = UITextView(frame: CGRect(x: 0, y: textViewY, width: view.frame.width, height: textViewHeight))
        originalTextViewFrame = textView.frame // Сохранение исходного размера UITextView
        view.addSubview(textView)
        textView.delegate = self // Установка делегата
        
        // Настройка свойств UITextView для прокрутки
        textView.isScrollEnabled = true
        textView.showsVerticalScrollIndicator = true
        textView.alwaysBounceVertical = true
    }
    
    func addButonIngrediensts() {
        // Создание UIButton
        let buttonY = imageView.frame.maxY
        let buttonHeight: CGFloat = 50
        ingredientsButton = UIButton(frame: CGRect(x: 0, y: buttonY, width: view.frame.width, height: buttonHeight))
        ingredientsButton.setTitle("Ингредиенты", for: .normal)
        ingredientsButton.addTarget(self, action: #selector(goToShoppingList), for: .touchUpInside)
        view.addSubview(ingredientsButton)
    }
    
    func addExpandButton() {
        // Добавление кнопки расширения
        let expandButtonSize: CGFloat = 44
        let expandButtonX = view.frame.width - expandButtonSize - 16
        let expandButtonY = textView.frame.origin.y - expandButtonSize - 8
        expandButton = UIButton(frame: CGRect(x: expandButtonX, y: expandButtonY, width: expandButtonSize, height: expandButtonSize))
        expandButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
        expandButton.addTarget(self, action: #selector(expandButtonTapped), for: .touchUpInside)
        expandButton.isHidden = true
        view.addSubview(expandButton)
        
    }
    
    private func addRecognizerTapToImage() {
        // Добавление жеста нажатия на картинку
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
    }
    
    private func setupBackgroundColor() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.orange.cgColor, UIColor.purple.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func goToNewController(viewController: UIViewController) {
           navigationController?.pushViewController(viewController, animated: true)
       }
    
    @objc func goToShoppingList(sender: UIButton!) {
        let viewController = ShoppingListViewController()
        if let recipeName = nameTF.text {
            viewController.viewModel.nameOfRecipe = recipeName
            goToNewController(viewController: viewController)
        }
    }
    
    @objc func expandButtonTapped() {
        textView.resignFirstResponder() // Скрытие клавиатуры
        textView.frame = originalTextViewFrame // Восстановление исходного размера UITextView
        expandButton.isHidden = true // Скрытие кнопки расширения
    }
    
    @objc func keyboardWillChangeFrame(_ notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        
        if !nameTF.isFirstResponder {
            if let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                // Обновление высоты UITextView при появлении клавиатуры
                let newTextViewHeight = view.frame.height
                textView.frame.size.height = newTextViewHeight
                textView.frame.origin.y = 0
                
                // Появление кнопки расширения над клавиатурой
                expandButton.frame.origin.y = keyboardFrame.origin.y - expandButton.frame.height - 8
                expandButton.isHidden = false
            }
        }
    }
}


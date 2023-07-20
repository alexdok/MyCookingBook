import UIKit

class NewRecipeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imageView: UIImageView!
    var ingredientsButton: UIButton!
    var textView: UITextView!
    var originalTextViewFrame: CGRect!
    var expandButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundColor()

        // Создание UIImageView
        let screenHeight = UIScreen.main.bounds.height
        let thirdHeight = screenHeight / 3
        imageView = UIImageView(frame: CGRect(x: 0, y: 20, width: view.frame.width, height: thirdHeight))
        imageView.backgroundColor = .green
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOffset = CGSize(width: 2, height: 2)
        imageView.layer.shadowOpacity = 0.5
        view.addSubview(imageView)
        
        addRecognizerTapToImage()
        
        // Создание UIButton
        let buttonY = imageView.frame.maxY
        let buttonHeight: CGFloat = 50
        ingredientsButton = UIButton(frame: CGRect(x: 0, y: buttonY, width: view.frame.width, height: buttonHeight))
        ingredientsButton.setTitle("Ингредиенты", for: .normal)
        ingredientsButton.addTarget(self, action: #selector(goToShoppingList), for: .touchUpInside)
        view.addSubview(ingredientsButton)
        
        // Создание UITextView
        let textViewY = ingredientsButton.frame.maxY
        let textViewHeight = screenHeight - thirdHeight - buttonHeight
        textView = UITextView(frame: CGRect(x: 0, y: textViewY, width: view.frame.width, height: textViewHeight))
        originalTextViewFrame = textView.frame // Сохранение исходного размера UITextView
        view.addSubview(textView)
        textView.delegate = self // Установка делегата
        
        // Настройка свойств UITextView для прокрутки
        textView.isScrollEnabled = true
        textView.showsVerticalScrollIndicator = true
        textView.alwaysBounceVertical = true
        
        addExpandButton()
        
        // Добавление наблюдателя для отслеживания изменений в высоте клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        expandButtonTapped()
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
    
    func toNewController(viewController: UIViewController) {
           navigationController?.pushViewController(viewController, animated: true)
       }
    
    @objc func goToShoppingList(sender: UIButton!) {
        toNewController(viewController: ShoppingListViewController())
    }

    @objc func imageTapped() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let alertController = UIAlertController(title: "Выберите источник изображения", message: nil, preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Камера", style: .default) { (action) in
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
        }
        alertController.addAction(cameraAction)
        
        let galleryAction = UIAlertAction(title: "Галерея", style: .default) { (action) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }
        alertController.addAction(galleryAction)
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imageView.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @objc func expandButtonTapped() {
        textView.resignFirstResponder() // Скрытие клавиатуры
        textView.frame = originalTextViewFrame // Восстановление исходного размера UITextView
        expandButton.isHidden = true // Скрытие кнопки расширения
    }
    
    @objc func keyboardWillChangeFrame(_ notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        
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

extension NewRecipeViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        // Скрытие кнопки расширения при начале редактирования
        expandButton.isHidden = true
    }
}

import UIKit

class ShoppingListTableViewCell: UITableViewCell {
    
    var buttonToAddNewCell: UIButton!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        textLabel?.text = nil
        accessoryType = .none
    }
    
    private func setupButton() {
        buttonToAddNewCell = createButton(title: "добавить", color: .green)
        applyButtonStyle(buttonToAddNewCell)
        addConstraintsButton()
    }
    
    private func createButton(title: String, color: UIColor) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.backgroundColor = color
        button.layer.cornerRadius = 10
        applyButtonStyle(button)
        return button
    }
    
    private func applyButtonStyle(_ button: UIButton) {
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    }
    
    private func addConstraintsButton() {
        contentView.addSubview(buttonToAddNewCell)
        buttonToAddNewCell.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            buttonToAddNewCell.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            buttonToAddNewCell.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            buttonToAddNewCell.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            buttonToAddNewCell.heightAnchor.constraint(equalTo: contentView.heightAnchor),
        ])
    }
    
    // Добавьте этот метод для настройки отображения информации в ячейке
    func configure(with item: Ingridient) {
        textLabel?.text = "\(item.type)      \(item.measuresOfMeasurement)"
    }
}


//
//class ShoppingListTableViewCell: UITableViewCell {
//
//    var buttonToAddNewCell: UIButton!
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//         super.init(style: style, reuseIdentifier: reuseIdentifier)
//         buttonToAddNewCell = createButton(title: "добавить", color: .green)
//         applyButtonStyle(buttonToAddNewCell)
//         addConstraintsButton()
//     }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        textLabel?.text = nil
//        accessoryType = .none
//    }
//
//     func createButton(title: String, color: UIColor) -> UIButton {
//        let button = UIButton(type: .system)
//        button.setTitle(title, for: .normal)
//        button.backgroundColor = color
//        button.layer.cornerRadius = 10
//         applyButtonStyle(button)
//        return button
//    }
//
//    private func applyButtonStyle(_ button: UIButton) {
//        button.setTitleColor(.black, for: .normal)
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
//    }
//
//     func addConstraintsButton() {
//        contentView.addSubview(buttonToAddNewCell)
//        buttonToAddNewCell.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            buttonToAddNewCell.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            buttonToAddNewCell.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            buttonToAddNewCell.widthAnchor.constraint(equalTo: contentView.widthAnchor),
//            buttonToAddNewCell.heightAnchor.constraint(equalTo: contentView.heightAnchor),
//        ])
//    }
//}

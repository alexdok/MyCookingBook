import UIKit

class CustomTableViewCell: UITableViewCell {
    
    let leftImageView: UIImageView = {
        let imageView = UIImageView()
        // Настройте свойства изображения
         imageView.image = UIImage(named: "imageName")
         imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .green
         imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let label1: UILabel = {
        let label = UILabel()
      //   Настройте свойства для первого лейбла
        label.textAlignment = .center
         label.textColor = UIColor.black
         label.font = UIFont.systemFont(ofSize: 14)
         label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let label2: UILabel = {
        let label = UILabel()
       //  Настройте свойства для второго лейбла
        label.textAlignment = .center
         label.textColor = UIColor.black
         label.font = UIFont.systemFont(ofSize: 14)
         label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let label3: UILabel = {
        let label = UILabel()
     //    Настройте свойства для третьего лейбла
        label.textAlignment = .center
         label.textColor = UIColor.black
         label.font = UIFont.systemFont(ofSize: 14)
         label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Добавьте лейблы и изображение в ячейку
        contentView.addSubview(leftImageView)
        contentView.addSubview(label1)
        contentView.addSubview(label2)
        contentView.addSubview(label3)
        
        // Настройка констрейнтов для элементов в ячейке
        // Используйте свои собственные значения для отступов и размеров
        NSLayoutConstraint.activate([
            leftImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            leftImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10),
            leftImageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            leftImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            leftImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/3),
            
            
    
            label1.bottomAnchor.constraint(equalTo: label2.topAnchor, constant: -30),
            label1.leadingAnchor.constraint(equalTo: leftImageView.trailingAnchor, constant: 30),
            label1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            
            label2.bottomAnchor.constraint(equalTo: label3.topAnchor, constant:  -30),
            label2.leadingAnchor.constraint(equalTo: leftImageView.trailingAnchor, constant: 30),
            label2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
           
            label3.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant:  -20),
            label3.leadingAnchor.constraint(equalTo: leftImageView.trailingAnchor, constant: 30),
            label3.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            label3.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

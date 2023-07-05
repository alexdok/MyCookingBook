//
//  CustomeTableViewCell.swift
//  testTUTU
//
//  Created by алексей ганзицкий on 05.07.2023.
//

import UIKit


class CustomTableViewCell: UITableViewCell {
    let leftImageView: UIImageView = {
        let imageView = UIImageView()
        // Настройте свойства изображения
         imageView.image = UIImage(named: "imageName")
         imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
         imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let label1: UILabel = {
        let label = UILabel()
      //   Настройте свойства для первого лейбла
         label.textColor = UIColor.black
         label.font = UIFont.systemFont(ofSize: 14)
         label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let label2: UILabel = {
        let label = UILabel()
       //  Настройте свойства для второго лейбла
         label.textColor = UIColor.black
         label.font = UIFont.systemFont(ofSize: 12)
         label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let label3: UILabel = {
        let label = UILabel()
     //    Настройте свойства для третьего лейбла
         label.textColor = UIColor.black
         label.font = UIFont.systemFont(ofSize: 10)
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
        let margins = contentView.layoutMarginsGuide
        NSLayoutConstraint.activate([
            leftImageView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            leftImageView.centerYAnchor.constraint(equalTo: margins.centerYAnchor),
            leftImageView.widthAnchor.constraint(equalToConstant: 50),
            leftImageView.heightAnchor.constraint(equalToConstant: 50),
            
            label1.leadingAnchor.constraint(equalTo: leftImageView.trailingAnchor, constant: 10),
            label1.topAnchor.constraint(equalTo: margins.topAnchor),
            label1.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            label2.leadingAnchor.constraint(equalTo: leftImageView.trailingAnchor, constant: 10),
            label2.topAnchor.constraint(equalTo: label1.bottomAnchor),
            label2.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            label3.leadingAnchor.constraint(equalTo: leftImageView.trailingAnchor, constant: 10),
            label3.topAnchor.constraint(equalTo: label2.bottomAnchor),
            label3.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            label3.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  MenuCollectionCell.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 18.02.2021.
//

import UIKit

class MenuCollectionCell: UICollectionViewCell, GeneralSetupProtocol {
    private let collectionModel = [
        CollectionModel(image: UIImage(named: "healthIcon"),
                        title: "Здоровье",
                        description: "Календарь прививок, лечение"),
        CollectionModel(image: UIImage(named: "documentIcon"),
                        title: "Документы",
                        description: "Паспорт, метрика, родословная и т.д."),
        CollectionModel(image: UIImage(named: "foodIcon"),
                        title: "Питание",
                        description: "Особенности рациона, кормление"),
        CollectionModel(image: UIImage(named: "careIcon"),
                        title: "Уход",
                        description: "Купание, расчёсывание, грумминг и т.д."),
        CollectionModel(image: UIImage(named: "funIcon"),
                        title: "Развлечения",
                        description: "Игры и развлечения питомца"),
    ]
    let titleImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        
        return label
    }()
    let descLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.CustomColor.gray
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
    }
    
    func menuCell() {
        self.addSubview(titleImage)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descLabel)
        self.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            titleImage.heightAnchor.constraint(equalToConstant: self.bounds.height / 2),
            titleImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleImage.leftAnchor.constraint(equalTo: self.leftAnchor,
                                             constant: (titleImage.bounds.height - self.bounds.height) / 2),
            
            containerView.heightAnchor.constraint(equalTo: titleImage.heightAnchor),
            containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            containerView.leftAnchor.constraint(equalTo: titleImage.rightAnchor,
                                                constant: titleImage.bounds.width / 4),
            containerView.rightAnchor.constraint(equalTo: self.rightAnchor,
                                               constant: -(titleImage.bounds.width / 4)),
            
            titleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: containerView.bounds.height / 2),
            
            titleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: containerView.bounds.height / 2)
        ])
    }
    
    func setupElements() {
        
    }
    
    func presentController() {
        
    }
    
}

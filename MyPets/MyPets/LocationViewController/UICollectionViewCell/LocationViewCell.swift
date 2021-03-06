//
//  LocationViewCell.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 23.10.2020.
//

import UIKit

class LocationViewCell: UICollectionViewCell {
    var model: BaseModel? {
        didSet {
            guard let model = model else { return }
            valueButton.setTitle(model.firstProperties, for: .normal)
        }
    }
    let valueButton = UIButton(type: .custom)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
        setupElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension LocationViewCell: GeneralSetupProtocol {

    func setupConstraints() {
        contentView.addSubview(valueButton)
        valueButton.topAnchor.constraint(equalTo: contentView.topAnchor,
                                         constant: 0).isActive = true
        valueButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                            constant: 0).isActive = true
        valueButton.leftAnchor.constraint(equalTo: contentView.leftAnchor,
                                          constant: 0).isActive = true
        valueButton.rightAnchor.constraint(equalTo: contentView.rightAnchor,
                                           constant: 0).isActive = true
    }
    
    func setupElements() {
        valueButton.translatesAutoresizingMaskIntoConstraints = false
        valueButton.clipsToBounds = true
        valueButton.layer.cornerRadius = 5
        valueButton.setBackgroundColor(UIColor.CustomColor.dark, forState: .highlighted)
        valueButton.setBackgroundColor(UIColor.CustomColor.lightGray, forState: .normal)
        valueButton.setTitleColor(.white, for: .highlighted)
        valueButton.setTitleColor(UIColor.CustomColor.dark, for: .normal)
        valueButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }
    
    func setupNavigationController() {}
    func presentController() {}
}

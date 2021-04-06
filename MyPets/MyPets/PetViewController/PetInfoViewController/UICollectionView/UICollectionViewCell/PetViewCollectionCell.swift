//
//  PetViewCollectionCell.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 28.10.2020.
//

import UIKit

class PetViewCollectionCell: UICollectionViewCell, GeneralSetupProtocol {
    weak var tableViewDelegate: PetTableViewDelegate?
    weak var delegate: PetViewControllerDelegate?
    var models = [BaseModel]()
    let label = UILabel()
    let titleLabel = UILabel()
    let tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.isScrollEnabled = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(PetViewTableCell.self, forCellReuseIdentifier: "tableCellPetId")
        
        return tv
    }()
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
    let menuTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = UIColor.CustomColor.dark
        
        return label
    }()
    let descLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = UIColor.CustomColor.dark.withAlphaComponent(0.8)
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
        setupElements()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableViewDelegate?.reloadTableView(tableView)
        delegate?.fetchTableView(tableView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        [label, tableView, titleLabel].forEach { contentView.addSubview($0) }
        
        label.topAnchor.constraint(equalTo: contentView.topAnchor,
                                   constant: 15).isActive = true
        label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                      constant: -15).isActive = true
        label.leftAnchor.constraint(equalTo: contentView.leftAnchor,
                                    constant: 15).isActive = true
        label.rightAnchor.constraint(equalTo: contentView.rightAnchor,
                                     constant: -15).isActive = true
        
        tableView.heightAnchor.constraint(lessThanOrEqualToConstant: 404).isActive = true
        tableView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                          constant: -20).isActive = true
        
        titleLabel.bottomAnchor.constraint(equalTo: tableView.topAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor,
                                        constant: 15).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,
                                         constant: 15).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor,
                                          constant: -15).isActive = true
    }
    
    func setupMenuCell() {
        self.addSubview(titleImage)
        self.addSubview(containerView)
        containerView.addSubview(menuTitleLabel)
        containerView.addSubview(descLabel)
        
        NSLayoutConstraint.activate([
            titleImage.heightAnchor.constraint(equalToConstant: self.bounds.height / 2),
            titleImage.widthAnchor.constraint(equalTo: titleImage.heightAnchor),
            titleImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleImage.leftAnchor.constraint(equalTo: self.leftAnchor,
                                             constant: self.bounds.height / 6),
            
            containerView.heightAnchor.constraint(equalTo: titleImage.heightAnchor),
            containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            containerView.leftAnchor.constraint(equalTo: titleImage.rightAnchor,
                                                constant: self.bounds.height / 6),
            containerView.rightAnchor.constraint(equalTo: self.rightAnchor,
                                               constant: -self.bounds.height / 6),
            
            menuTitleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            menuTitleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            menuTitleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            menuTitleLabel.heightAnchor.constraint(equalToConstant: self.bounds.height / 4),
            
            descLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            descLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            descLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            descLabel.heightAnchor.constraint(equalToConstant: self.bounds.height / 4)
        ])
    }
    
    func setupElements() {
        [label, titleLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        label.backgroundColor = .white

        titleLabel.textColor = UIColor.CustomColor.dark
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 1
    }
    
    func setupNavigationController() {}
    func presentController() {}
}

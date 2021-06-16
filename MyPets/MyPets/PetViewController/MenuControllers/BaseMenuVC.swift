//
//  BaseMenuVC.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 12.04.2021.
//

import UIKit

class BaseMenuVC: UIViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var baseText: String?
    var indexPath = Int()
    var models = [BaseModel()]
    let closeButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "closeButton"), for: .normal)
        btn.contentHorizontalAlignment = .fill
        btn.contentVerticalAlignment = .fill
        btn.addTarget(self, action: #selector(closeController), for: .touchUpInside)
        btn.tintColor = UIColor.CustomColor.gray
        
        return btn
    }()
    let primaryView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.CustomColor.dark.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 0.20
        view.layer.masksToBounds = false
        view.layer.shadowRadius = 7
        
        return view
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.CustomColor.dark
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .left
        label.numberOfLines = 1
        
        return label
    }()
    let tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.isScrollEnabled = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(BaseMenuCell.self, forCellReuseIdentifier: "baseMenuCell")
        tv.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        tv.layer.cornerRadius = 20
        
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(primaryView)
        primaryView.addSubview(titleLabel)
        primaryView.addSubview(closeButton)
        primaryView.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            primaryView.heightAnchor.constraint(equalToConstant: 45 * 7),
            primaryView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 1.1),
            primaryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            primaryView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            titleLabel.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 30),
            titleLabel.widthAnchor.constraint(equalToConstant: view.bounds.width / 1.2),
            titleLabel.topAnchor.constraint(equalTo: primaryView.topAnchor, constant: UIScreen.main.bounds.height / 35),
            titleLabel.centerXAnchor.constraint(equalTo: primaryView.centerXAnchor),
            
            closeButton.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 30 / 2),
            closeButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 30 / 2),
            closeButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            closeButton.rightAnchor.constraint(equalTo: titleLabel.rightAnchor),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: UIScreen.main.bounds.height / 35),
            tableView.bottomAnchor.constraint(equalTo: primaryView.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: primaryView.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: primaryView.rightAnchor)
        ])
    }
    
}

class BaseMenuCell: UITableViewCell, GeneralSetupProtocol {
    var tableCellLabel = UILabel()
    let tableCellPlaceholder = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupConstraints()
        setupElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        contentView.addSubview(tableCellLabel)
        contentView.addSubview(tableCellPlaceholder)
        
        tableCellLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,
                                             constant: 15).isActive = true
        tableCellLabel.rightAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        tableCellLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        tableCellLabel.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        tableCellPlaceholder.leftAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        tableCellPlaceholder.rightAnchor.constraint(equalTo: contentView.rightAnchor,
                                                    constant: -15).isActive = true
        tableCellPlaceholder.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        tableCellPlaceholder.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    func setupElements() {
        [tableCellLabel, tableCellPlaceholder].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        tableCellLabel.textAlignment = .left
        tableCellLabel.textColor = UIColor.CustomColor.dark
        tableCellLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        tableCellLabel.adjustsFontSizeToFitWidth = true
        
        tableCellPlaceholder.textAlignment = .right
        tableCellPlaceholder.textColor = UIColor.CustomColor.gray
        tableCellPlaceholder.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        tableCellPlaceholder.adjustsFontSizeToFitWidth = true
        
    }
    
    func setupNavigationController() {}
    func presentController() {}
}

extension BaseMenuVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "baseMenuCell") as! BaseMenuCell
        cell.tableCellLabel.text = models[indexPath.row].firstProperties
        cell.tableCellPlaceholder.text = (models[indexPath.row].secondProperties ?? "Указать информацию")
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .default
                
        return cell
    }
    
    @objc func closeController() {
        self.dismiss(animated: true, completion: nil)
    }
}

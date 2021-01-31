//
//  SupportViewController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 31.01.2021.
//

import UIKit

class  SupportViewController: UIViewController {
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "supportCell")
        
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        view = tableView
        
        view.backgroundColor = .white
    }
    
}

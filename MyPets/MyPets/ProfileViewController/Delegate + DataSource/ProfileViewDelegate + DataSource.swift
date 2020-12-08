//
//  ProfileViewDelegate + DataSource.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 08.12.2020.
//

import UIKit

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//            let titles = ["",
//                          "",
//                          "УВЕДОМЛЕНИЯ",
//                          "Неограниченное количество питомцев и множество дополнительных функций доступно в Premium",
//                          "",
//                          ""]
            let titles = ["",
                          "",
                          "УВЕДОМЛЕНИЯ",
                          "",
                          "",
                          ""]
    
            return titles[section]
        }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0, 3, 5:
            return 1
        default:
            return 2
        }
        
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath)
        
        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            content.text = "Cell - \(indexPath.row)"
            cell.contentConfiguration = content
        } else {
            cell.textLabel?.text = "Cell - \(indexPath.row)"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(indexPath.row)
    }
}

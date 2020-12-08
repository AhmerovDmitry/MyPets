//
//  ProfileViewDelegate + DataSource.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 08.12.2020.
//

import UIKit

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let titles = [nil,
                      nil,
                      "УВЕДОМЛЕНИЯ",
                      nil,
                      nil,
                      nil]
        
        return titles[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return menuTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuTitles[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath)
        let menuTitle = menuTitles[indexPath.section]
        
        switch indexPath.section {
        case 0:
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "profileCell")
        default:
            cell = UITableViewCell(style: .default, reuseIdentifier: "profileCell")
        }
        
        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            content.text = menuTitle[indexPath.row]
            content.secondaryText = "Мои данные"
            content.secondaryTextProperties.color = UIColor.CustomColor.gray
            content.image = UIImage(named: "cameraIcon")
            if indexPath.section != 0 {
                content.secondaryText = nil
                content.image = nil
            }
            if indexPath.section == menuTitles.endIndex - 1 {
                content.textProperties.color = .red
            }
            cell.contentConfiguration = content
        } else {
            cell.textLabel?.text = menuTitle[indexPath.row]
            cell.detailTextLabel?.text = "Мои данные"
            cell.detailTextLabel?.textColor = UIColor.CustomColor.gray
            cell.imageView?.image = UIImage(named: "cameraIcon")
            if indexPath.section != 0 {
                cell.detailTextLabel?.text = nil
                cell.imageView?.image = nil
            }
            if indexPath.section == menuTitles.endIndex - 1 {
                cell.textLabel?.textColor = .red
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

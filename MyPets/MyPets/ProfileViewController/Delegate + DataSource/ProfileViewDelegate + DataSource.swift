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
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "profileCell")
        let menuTitle = menuTitles[indexPath.section]
        
        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            if indexPath.section == 0 {
                content.text = menuTitle[indexPath.row]
                content.secondaryText = "Мои данные"
                content.secondaryTextProperties.color = UIColor.CustomColor.gray
                content.image = UIImage(named: "cameraIcon")
            } else if indexPath.section == 3 {
                content.text = menuTitle[indexPath.row]
                content.image = UIImage(named: "crownIcon")
            } else {
                content.text = menuTitle[indexPath.row]
            }
            if indexPath.section == menuTitles.endIndex - 1 {
                content.textProperties.color = .red
            }
            cell.contentConfiguration = content
        } else {
            if indexPath.section == 0 {
                cell.textLabel?.text = menuTitle[indexPath.row]
                cell.detailTextLabel?.text = "Мои данные"
                cell.detailTextLabel?.textColor = UIColor.CustomColor.gray
                cell.imageView?.image = UIImage(named: "cameraIcon")
            } else if indexPath.section == 3 {
                cell.textLabel?.text = menuTitle[indexPath.row]
                cell.imageView?.image = UIImage(named: "crownIcon")
            } else {
                cell.textLabel?.text = menuTitle[indexPath.row]
            }
            if indexPath.section == menuTitles.endIndex - 1 {
                cell.textLabel?.textColor = .red
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            let userProfileVC = UserProfileViewController()
            navigationController?.pushViewController(userProfileVC, animated: true)
        }
    }
}

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
        cell = ProfileViewCell(style: .subtitle, reuseIdentifier: "profileCell")
        
        let menuTitle = menuTitles[indexPath.section]
        
        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            if indexPath.section == 0 {
                content.imageProperties.maximumSize = CGSize(width: 40, height: 40)
                content.image = userImage
                if userImage == nil {
                    content.image = UIImage(named: "cameraIcon")
                    //content.imageProperties.cornerRadius = 20
                }
                content.text = userName
                if userName == nil {
                    content.text = menuTitle[indexPath.row]
                }
                content.secondaryText = "Мои данные"
                content.secondaryTextProperties.color = UIColor.CustomColor.gray
            } else if indexPath.section == 3 {
                content.text = menuTitle[indexPath.row]
                content.image = UIImage(named: "crownIcon")
            } else {
                content.text = menuTitle[indexPath.row]
            }
            cell.contentConfiguration = content
        } else {
            if indexPath.section == 0 {
                if userImage != nil {
                    cell.imageView?.image = userImage
                } else {
                    cell.imageView?.image = UIImage(named: "cameraIcon")
                }
                if userName != nil {
                    cell.textLabel?.text = userName
                } else {
                    cell.textLabel?.text = menuTitle[indexPath.row]
                }
                cell.detailTextLabel?.text = "Мои данные"
                cell.detailTextLabel?.textColor = UIColor.CustomColor.gray
            } else if indexPath.section == 2 {
                cell.textLabel?.text = menuTitle[indexPath.row]
                switch indexPath.row {
                case 0:
                    cell.addSubview(tipsSwitch)
                    tipsSwitch.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
                    tipsSwitch.rightAnchor.constraint(equalTo: cell.rightAnchor,
                                                      constant: -10).isActive = true
                case 1:
                    cell.addSubview(reminderSwitch)
                    reminderSwitch.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
                    reminderSwitch.rightAnchor.constraint(equalTo: cell.rightAnchor,
                                                          constant: -10).isActive = true
                default: break
                }
                
            } else if indexPath.section == 3 {
                cell.textLabel?.text = menuTitle[indexPath.row]
                cell.imageView?.image = UIImage(named: "crownIcon")
            } else {
                cell.textLabel?.text = menuTitle[indexPath.row]
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.section {
        case 0:
            let userProfileVC = UserProfileViewController()
            userProfileVC.delegate = self
            userProfileVC.profileView.setBackgroundImage(userImage, for: .normal)
            navigationController?.pushViewController(userProfileVC, animated: true)
        case 3:
            presentPremiumController(on: self.tabBarController!)
        case 4:
            switch indexPath.row {
            case 0:
                let supportController = SupportViewController()
                navigationController?.pushViewController(supportController, animated: true)
            case 1:
                let aboutAppController = AboutAppController()
                navigationController?.pushViewController(aboutAppController, animated: true)
            default: break
            }
        default: break
        }
        
    }
}

extension ProfileViewController: ProfileViewControllerDelegate {
    func updateUser(image: UIImage?) {
        userImage = image
        tableView.reloadData()
    }
}

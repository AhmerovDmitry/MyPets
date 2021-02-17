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
        var cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath) as! ProfileViewCell
        let menuTitle = menuTitles[indexPath.section]
        if indexPath.section == 0 {
            cell = ProfileViewCell(style: .subtitle, reuseIdentifier: "profileCell")
            if let data = userInfo.image {
                cell.userImageView.image = UIImage(data: data)
            } else {
                cell.userImageView.contentMode = .center
                cell.userImageView.image = UIImage(named: "cameraIcon")
            }
            cell.nameLabel.text = userInfo.name ?? menuTitle[indexPath.row]
            cell.descLabel.text = "Мои данные"
            cell.descLabel.textColor = UIColor.CustomColor.gray
        } else {
            cell = ProfileViewCell(style: .default, reuseIdentifier: "profileCell")
        }
        
        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            if indexPath.section == 0 {
                content.text = nil
            } else {
                content.text = menuTitle[indexPath.row]
            }
            if indexPath.section == 3 {
                content.image = UIImage(named: "crownIcon")
            }
            cell.contentConfiguration = content
        } else {
            if indexPath.section == 0 {
                cell.textLabel?.text = nil
            } else {
                cell.textLabel?.text = menuTitle[indexPath.row]
            }
            if indexPath.section == 2 {
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
                cell.imageView?.image = UIImage(named: "crownIcon")
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
            userProfileVC.userInfo = userInfo
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
    func updateUser(profile: UserProfileModel) {
        userInfo = profile
        tableView.reloadData()
    }
}

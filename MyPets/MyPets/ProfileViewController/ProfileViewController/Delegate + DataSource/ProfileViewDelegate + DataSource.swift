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
        guard var cell = tableView.dequeueReusableCell(
            withIdentifier: "profileCell", for: indexPath
        ) as? ProfileViewCell else { return UITableViewCell() }
        let menuTitle = menuTitles[indexPath.section]
        if indexPath.section == 0 {
            cell = ProfileViewCell(style: .subtitle, reuseIdentifier: "profileCell")
            cell.userImageView.contentMode = .center
            cell.userImageView.image = UIImage(named: "cameraIcon")
            cell.nameLabel.text = userInfo.name
            if let data = userInfo.image { cell.userImageView.image = UIImage(data: data) }
            if userInfo.name == "Указать информацию" || userInfo.name == nil {
                cell.nameLabel.text = menuTitle[indexPath.row]
            }
        }
        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            content.textProperties.color = UIColor.CustomColor.dark
            content.textProperties.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            if indexPath.section != 0 { content.text = menuTitle[indexPath.row] }
            if indexPath.section == 3 { content.image = UIImage(named: "crownIcon") }
            cell.contentConfiguration = content
        } else {
            cell.textLabel?.textColor = UIColor.CustomColor.dark
            cell.textLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            if indexPath.section == 0 { cell.textLabel?.text = nil
            } else {
                cell.textLabel?.text = menuTitle[indexPath.row]
            }
            if indexPath.section == 2 {
                switch indexPath.row {
                case 0:
                    cell.addSubview(tipsSwitch)
                    tipsSwitch.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
                    tipsSwitch.rightAnchor.constraint(equalTo: cell.rightAnchor, constant: -10).isActive = true
                case 1:
                    cell.addSubview(reminderSwitch)
                    reminderSwitch.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
                    reminderSwitch.rightAnchor.constraint(equalTo: cell.rightAnchor, constant: -10).isActive = true
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
            let backItem = UIBarButtonItem()
            backItem.title = " "
            navigationItem.backBarButtonItem = backItem
            let userProfileVC = UserProfileViewController()
            userProfileVC.delegate = self
            userProfileVC.userInfo = userInfo
            navigationController?.pushViewController(userProfileVC, animated: true)
        case 3:
            presentPremiumController(self.tabBarController)
        case 4:
            switch indexPath.row {
            case 0:
                let backItem = UIBarButtonItem()
                backItem.title = " "
                navigationItem.backBarButtonItem = backItem
                let supportController = SupportViewController()
                navigationController?.pushViewController(supportController, animated: true)
            case 1:
                let backItem = UIBarButtonItem()
                backItem.title = " "
                navigationItem.backBarButtonItem = backItem
                let aboutAppController = AboutAppController()
                navigationController?.pushViewController(aboutAppController, animated: true)
            case 2:
                UserDefaults.standard.set(false, forKey: "isFirstLaunch")
            case 3:
                UserDefaults.standard.set(false, forKey: "paidStatus")
            case 4:
                if !CoreDataManager.shared.pets.isEmpty {
                    CoreDataManager.shared.deleteEntity(at: CoreDataManager.shared.pets.count - 1)
                }
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

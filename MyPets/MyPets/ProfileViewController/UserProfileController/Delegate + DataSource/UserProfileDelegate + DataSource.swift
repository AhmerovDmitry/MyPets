//
//  UserProfileDelegate + DataSource.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 02.01.2021.
//

import UIKit

extension UserProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userProfileCell", for: indexPath) as! PetViewTableCell
        cell.tableCellLabel.text = models[indexPath.row].title
        cell.tableCellPlaceholder.text = models[indexPath.row].info
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = .white
        
        switch indexPath.row {
        case 0:
            if userInfo.name != nil {
                cell.tableCellPlaceholder.text = userInfo.name
            }
            if userInfo.name == "Указать информацию" {
                userInfo.name = nil
            }
        case 1:
            if userInfo.city != nil {
                cell.tableCellPlaceholder.text = userInfo.city
            }
            if userInfo.city == "Указать информацию" {
                userInfo.city = nil
            }
        case 2:
            if userInfo.eMail != nil {
                cell.tableCellPlaceholder.text = userInfo.eMail
            }
            if userInfo.eMail == "Указать информацию" {
                userInfo.eMail = nil
            }
        default: break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            alertForUserInformation(title: "Укажите ваше имя", message: "test message", textFieldIndex: indexPath)
        case 1:
            alertForUserInformation(title: "Укажите ваш город", message: "test message", textFieldIndex: indexPath)
        case 2:
            alertForUserInformation(title: "Укажите ваш e-mail", message: "test message", textFieldIndex: indexPath)
        default: break
        }
    }
}

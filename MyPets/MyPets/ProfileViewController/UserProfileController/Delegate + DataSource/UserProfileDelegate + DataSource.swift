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
//        let cell = tableView.dequeueReusableCell(
//            withIdentifier: "userProfileCell",
//            for: indexPath
//        ) as! UITableViewController
//        cell.tableCellLabel.text = models[indexPath.row].firstProperties
//        cell.accessoryType = .disclosureIndicator
//        cell.backgroundColor = .white
//
//        switch indexPath.row {
//        case 0:
//            cell.tableCellPlaceholder.text = userInfo.name ?? models[0].secondProperties
//        case 1:
//            cell.tableCellPlaceholder.text = userInfo.city ?? models[1].secondProperties
//        case 2:
//            cell.tableCellPlaceholder.text = userInfo.eMail ?? models[2].secondProperties
//        default: break
//        }
//
//        return cell
        return UITableViewCell()
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

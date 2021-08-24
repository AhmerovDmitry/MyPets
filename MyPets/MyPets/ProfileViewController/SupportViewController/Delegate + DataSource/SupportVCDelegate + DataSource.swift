//
//  SupportVCDelegate + DataSource.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 31.01.2021.
//

import UIKit

extension SupportViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "supportCell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.textColor = UIColor.CustomColor.dark
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Вопрос о работе приложения"
        case 1:
            cell.textLabel?.text = "Связаться с дизайнером приложения"
        case 2:
            cell.textLabel?.text = "Связаться с разработчиком приложения"
        default: break
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            sendRequest(toMail: "ahmerov.dmitry@gmail.com")
        case 1:
            sendRequest(toMail: "ahmerov.dmitry@gmail.com")
        case 2:
            sendRequest(toMail: "ahmerov.dmitry@gmail.com")
        default: break
        }
    }
}

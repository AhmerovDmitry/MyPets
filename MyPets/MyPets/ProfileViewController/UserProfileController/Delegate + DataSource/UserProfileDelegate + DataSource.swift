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
        cell.tableCellLable.text = models[indexPath.row].title
        cell.tableCellPlaceholder.text = (models[indexPath.row].info ?? "Указать информацию")
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = .white
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

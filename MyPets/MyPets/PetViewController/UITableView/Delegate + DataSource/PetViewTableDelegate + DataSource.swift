//
//  PetViewTableDelegate + DataSource.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 28.10.2020.
//

import UIKit

extension PetViewCollectionCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        9
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCellPetId") as! PetViewTableCell
        cell.tableCellLable.text = models[indexPath.row].title
        cell.tableCellPlaceholder.text = (models[indexPath.row].info ?? "Указать информацию") + " ❯"
        cell.backgroundColor = .white
        cell.selectionStyle = .none
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.item)
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCellPetId") as! PetViewTableCell
        cell.presentAlertController()
        
    }
}

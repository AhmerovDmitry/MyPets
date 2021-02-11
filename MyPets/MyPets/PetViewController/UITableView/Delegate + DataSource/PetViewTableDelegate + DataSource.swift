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
        cell.tableCellLabel.text = models[indexPath.row].title
        cell.tableCellPlaceholder.text = (models[indexPath.row].info ?? "Указать информацию")
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = .white
        
        titleLabel.text = models[0].info
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        delegate?.fetchTableInfo(tableView: tableView,
                                 indexPath: indexPath,
                                 updateInformation: updatePetInfo(indexPath:))
        
        let messageText = "Если вы не располагаете данной информацией, можете оставить поле ввода пустым"
        let titleText = ["Укажите кличку питомца",
                         "Укажите вид питомца",
                         "Укажите породу питомца",
                         "",
                         "Укажите вес питомца",
                         "Укажите стерилизован ли питомец",
                         "Укажите окрас питомца",
                         "Укажите шерсть питомца",
                         "Укажите номер чипа питомца"]
        
        switch indexPath.row {
        case 3:
            delegate?.showDatePicker()
        default:
            delegate?.showAlertController(title: titleText[indexPath.row],
                                          message: messageText)
        }
    }
    
    func updatePetInfo(indexPath: IndexPath) {
        let petInformation = delegate?.petInfoForModel()
        if petInformation == nil {
            models[indexPath.row].info = " "
        } else {
            models[indexPath.row].info = petInformation
        }
    }
}

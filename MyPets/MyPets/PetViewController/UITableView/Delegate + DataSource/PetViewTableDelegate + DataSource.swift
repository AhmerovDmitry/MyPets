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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            delegate?.showAlertController(title: "Укажите кличку питомца",
                                          message: "Если вы не располагаете данной информацией, можете оставить поле ввода пустым",
                                          tableView: tableView)
        case 1:
            delegate?.showAlertController(title: "Укажите вид питомца",
                                          message: "Если вы не располагаете данной информацией, можете оставить поле ввода пустым",
                                          tableView: tableView)
        case 2:
            delegate?.showAlertController(title: "Укажите породу питомца",
                                          message: "Если вы не располагаете данной информацией, можете оставить поле ввода пустым",
                                          tableView: tableView)
        case 3:
            delegate?.showAlertController(title: "Укажите дату рождения питомца",
                                          message: "Если вы не располагаете данной информацией, можете оставить поле ввода пустым",
                                          tableView: tableView)
        case 4:
            delegate?.showAlertController(title: "Укажите вес питомца",
                                          message: "Если вы не располагаете данной информацией, можете оставить поле ввода пустым",
                                          tableView: tableView)
        case 5:
            delegate?.showAlertController(title: "Укажите стерилизован ли питомец",
                                          message: "Если вы не располагаете данной информацией, можете оставить поле ввода пустым",
                                          tableView: tableView)
        case 6:
            delegate?.showAlertController(title: "Укажите окрас питомца",
                                          message: "Если вы не располагаете данной информацией, можете оставить поле ввода пустым",
                                          tableView: tableView)
        case 7:
            delegate?.showAlertController(title: "Укажите шерсть питомца",
                                          message: "Если вы не располагаете данной информацией, можете оставить поле ввода пустым",
                                          tableView: tableView)
        case 8:
            delegate?.showAlertController(title: "Укажите номер чипа питомца",
                                          message: "Если вы не располагаете данной информацией, можете оставить поле ввода пустым",
                                          tableView: tableView)
        default: break
        }
    }
}

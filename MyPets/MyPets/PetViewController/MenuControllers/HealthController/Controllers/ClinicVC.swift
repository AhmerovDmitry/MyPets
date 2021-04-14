//
//  ClinicVC.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 12.04.2021.
//

import UIKit

class ClinicVC: BaseMenuVC, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.models = [
            BaseModel(firstProperties: "Телефон", secondProperties: nil),
            BaseModel(firstProperties: "Адрес", secondProperties: nil),
            BaseModel(firstProperties: "Сайт", secondProperties: nil),
            BaseModel(firstProperties: "Врач", secondProperties: nil),
            BaseModel(firstProperties: "Отображать на главной", secondProperties: " ")
        ]
        self.titleLabel.text = "Моя ветклиника"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "baseMenuCell", for: indexPath) as! BaseMenuCell
        cell.tableCellLabel.text = models[indexPath.row].firstProperties
        cell.tableCellPlaceholder.text = (models[indexPath.row].secondProperties ?? "Указать информацию")
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .default
        
        if indexPath.row == models.count - 1 {
            cell.accessoryType = .none
            cell.selectionStyle = .none
            let displaySwitch: UISwitch = {
                let element = UISwitch()
                element.translatesAutoresizingMaskIntoConstraints = false
                element.isOn = false
                
                return element
            }()
            cell.addSubview(displaySwitch)
            
            NSLayoutConstraint.activate([
                displaySwitch.centerYAnchor.constraint(equalTo: cell.centerYAnchor),
                displaySwitch.rightAnchor.constraint(equalTo: cell.tableCellPlaceholder.rightAnchor)
            ])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.indexPath = indexPath.row
        let messageText = "Если вы не располагаете данной информацией, можете оставить поле ввода пустым"
        let titleText = ["Укажите телефон ветклиники",
                         "Укажите адрес ветклиники",
                         "Укажите сайт ветклиники",
                         "Укажите лечащего врача"]
        if indexPath.row != models.count - 1 {
            alertToInputInformation(title: titleText[indexPath.row], message: messageText, self)
        }
    }
    
    func alertToInputInformation(title: String,
                                 message: String,
                                 _ controller: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.textAlignment = .left
            textField.textColor = UIColor.CustomColor.dark
            textField.placeholder = "Введите информацию"
            textField.addTarget(self,
                                action: #selector(self.textFieldDidEndEditing(_:)),
                                for: .editingDidEnd)
            switch self.indexPath {
            case 0:
                textField.keyboardType = .numberPad
                textField.text = self.baseText
            case 1:
                textField.text = self.baseText
            case 2:
                textField.text = self.baseText
            case 3:
                textField.text = self.baseText
            default: break
            }
        }
        let saveButton = UIAlertAction(title: "Сохранить", style: .default) { _ in
            switch self.indexPath {
            case 0:
                self.models[0].secondProperties = self.baseText
            case 1:
                self.models[1].secondProperties = self.baseText
            case 2:
                self.models[2].secondProperties = self.baseText
            case 3:
                self.models[3].secondProperties = self.baseText
            default: break
            }
            self.baseText = nil
            self.tableView.reloadData()
        }
        let cancelButton = UIAlertAction(title: "Отменить", style: .cancel)
        alert.addAction(saveButton)
        alert.addAction(cancelButton)
        
        controller.present(alert, animated: true, completion: nil)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == "" {
            baseText = nil
        } else {
            baseText = textField.text
        }
    }
    
}

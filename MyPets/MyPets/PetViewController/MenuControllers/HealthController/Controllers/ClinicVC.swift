//
//  ClinicVC.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 12.04.2021.
//

import UIKit
import CoreData

class ClinicVC: BaseMenuVC, UITextFieldDelegate {
//    var clinicEntity = Clinic()
//    var clinic = [ClinicEntity]()
    
    let displaySwitch: UISwitch = {
        let element = UISwitch()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.isOn = false
        
        return element
    }()
    
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "baseMenuCell", for: indexPath) as? BaseMenuCell else { return UITableViewCell() }
        cell.tableCellLabel.text = models[indexPath.row].firstProperties
        cell.tableCellPlaceholder.text = (models[indexPath.row].secondProperties ?? "Указать информацию")
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .default
        
        if indexPath.row == models.count - 1 {
            cell.accessoryType = .none
            cell.selectionStyle = .none
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
            textField.text = self.models[self.indexPath].secondProperties
            
            if self.indexPath == 0 {
                textField.keyboardType = .numberPad
            }
            
        }
        let saveButton = UIAlertAction(title: "Сохранить", style: .default) { _ in
            switch self.indexPath {
//            case 0: self.clinicEntity.phone = self.baseText
//            case 1: self.clinicEntity.address = self.baseText
//            case 2: self.clinicEntity.site = self.baseText
//            case 3: self.clinicEntity.doctor = self.baseText
            default: break
            }
            self.models[self.indexPath].secondProperties = self.baseText
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

//extension ClinicVC {
//    func loadClinicInfo() {
//        let fetchRequest: NSFetchRequest<ClinicEntity> = ClinicEntity.fetchRequest()
//
//        do {
//            clinic = try context.fetch(fetchRequest)
//        } catch let error {
//            print(error.localizedDescription)
//        }
//    }
//
//    func createClinicInfo(_ entity: Any) {
//        guard let clinicEnt = NSEntityDescription.entity(forEntityName: "ClinicEntity", in: self.context) else { return }
//        let clinic = ClinicEntity(entity: clinicEnt, insertInto: context)
//        let entity = entity as! Clinic
//
//        clinicEntity.address = entity.phone
//        clinicEntity.doctor = entity.phone
//        clinicEntity.phone = entity.phone
//        clinicEntity.site = entity.phone
//
//        do {
//            self.clinic.insert(clinic, at: 0)
//            try context.save()
//        } catch let error {
//            context.rollback()
//            print(error.localizedDescription)
//        }
//    }
//
//    func updateClinicInfo(_ entity: Any, at index: Int) {
//
//    }
//
//    func deleteClinicInfo(at index: Int) {
//
//    }
//}

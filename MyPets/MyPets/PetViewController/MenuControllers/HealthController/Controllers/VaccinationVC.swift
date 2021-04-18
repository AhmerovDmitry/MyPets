//
//  VaccinationVC.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 12.04.2021.
//

import UIKit

class VaccinationVC: BaseMenuVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.models = [
            BaseModel(firstProperties: "Телефон", secondProperties: "Указать информацию"),
            BaseModel(firstProperties: "Адрес", secondProperties: "Указать информацию"),
            BaseModel(firstProperties: "Сайт", secondProperties: "Указать информацию"),
            BaseModel(firstProperties: "Врач", secondProperties: "Указать информацию"),
            BaseModel(firstProperties: "Отображать на главной", secondProperties: "Указать информацию")
        ]
        self.titleLabel.text = "Моя ветклиника"
    }
    
}

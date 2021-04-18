//
//  TreatmentVC.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 12.04.2021.
//

import UIKit

class TreatmentVC: BaseMenuVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.models = [
            BaseModel(firstProperties: "Препарат", secondProperties: "Указать информацию"),
            BaseModel(firstProperties: "Последняя обработка", secondProperties: "Указать информацию"),
            BaseModel(firstProperties: "Повторить", secondProperties: "Указать информацию"),
            BaseModel(firstProperties: "Напомнить", secondProperties: "Указать информацию")
        ]
        self.titleLabel.text = "Обработка от блох и клещей"
    }
    
}

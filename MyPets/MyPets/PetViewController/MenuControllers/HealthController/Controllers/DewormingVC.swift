//
//  DewormingVC.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 12.04.2021.
//

import UIKit

class DewormingVC: BaseMenuVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.models = [
            BaseModel(firstProperties: "Препарат", secondProperties: "Указать информацию"),
            BaseModel(firstProperties: "Последний приём", secondProperties: "Указать информацию"),
            BaseModel(firstProperties: "Повторить", secondProperties: "Указать информацию"),
            BaseModel(firstProperties: "Напомнить", secondProperties: "Указать информацию")
        ]
        self.titleLabel.text = "Дегельминтизация"
    }
}

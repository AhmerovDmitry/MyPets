//
//  MainPetViewController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 15.10.2020.
//

import UIKit

class MainPetViewController: UIViewController {
    static let shared = MainPetViewController()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    lazy var pets = [PetEntity]()
}

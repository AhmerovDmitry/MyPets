//
//  AboutAppController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 16.01.2021.
//

import UIKit

class AboutAppController: UIViewController {
    let appVersion: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Версия приложения: \(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String)"
        label.textAlignment = .center
        
        return label
    }()
    let designerInfo: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Дизайнер: Екатерина Лемина"
        label.textAlignment = .center
        
        return label
    }()
    let developerInfo: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Разработчик: Дмитрий Ахмеров"
        label.textAlignment = .center
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        [appVersion, designerInfo, developerInfo].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            appVersion.leftAnchor.constraint(equalTo: view.leftAnchor),
            appVersion.rightAnchor.constraint(equalTo: view.rightAnchor),
            appVersion.bottomAnchor.constraint(equalTo: designerInfo.topAnchor),
            
            designerInfo.leftAnchor.constraint(equalTo: view.leftAnchor),
            designerInfo.rightAnchor.constraint(equalTo: view.rightAnchor),
            designerInfo.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            developerInfo.topAnchor.constraint(equalTo: designerInfo.bottomAnchor),
            developerInfo.leftAnchor.constraint(equalTo: view.leftAnchor),
            developerInfo.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
    }
    
}

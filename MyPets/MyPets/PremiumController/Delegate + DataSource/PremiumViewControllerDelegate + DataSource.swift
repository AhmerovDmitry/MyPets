//
//  PremiumViewControllerDelegate + DataSource.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 12.10.2020.
//

import UIKit

extension PremiumViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! PremiumViewControllerCell
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        let data = models[indexPath.row]
        cell.model = data
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellHeight = tableView.frame.size.height / CGFloat(models.count)
        return cellHeight
    }
}

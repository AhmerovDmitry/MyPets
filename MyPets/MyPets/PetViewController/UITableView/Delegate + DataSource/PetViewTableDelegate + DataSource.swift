//
//  PetViewTableDelegate + DataSource.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 28.10.2020.
//

import UIKit

extension PetViewCollectionCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCellPetId") as! PetViewTableCell
        cell.labelTable.text = "pets pets pets"
        
        return cell
    }
}

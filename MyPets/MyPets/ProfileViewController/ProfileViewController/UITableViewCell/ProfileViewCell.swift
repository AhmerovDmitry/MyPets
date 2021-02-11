//
//  ProfileViewCell.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 09.01.2021.
//

import UIKit

class ProfileViewCell: UITableViewCell {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.imageView?.clipsToBounds = true
        self.imageView?.layer.cornerRadius = 20
        self.imageView?.bounds.size = CGSize(width: 40,
                                             height: 40)
        if self.imageView?.image == UIImage(named: "cameraIcon") {
            self.imageView?.contentMode = .center
        } else {
            self.imageView?.contentMode = .scaleAspectFill
        }
    }
}

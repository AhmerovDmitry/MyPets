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
        
        self.imageView?.bounds.size = CGSize(width: 40, height: 40)
        self.imageView?.clipsToBounds = true
        self.imageView?.layer.cornerRadius = 20
        self.imageView?.contentMode = .center
    }
    
    
//    let profileImageView:UIImageView = {
//        let img = UIImageView()
//        img.contentMode = .scaleAspectFill
//        img.translatesAutoresizingMaskIntoConstraints = false
//        img.layer.cornerRadius = img.bounds.height / 2
//        img.clipsToBounds = true
//
//        return img
//    }()
//
//    let nameLabel:UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        
//        return label
//    }()
//
//    let jobTitleDetailedLabel:UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        return label
//    }()
//
//    let containerView:UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.clipsToBounds = true
//
//        return view
//    }()
    
    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}

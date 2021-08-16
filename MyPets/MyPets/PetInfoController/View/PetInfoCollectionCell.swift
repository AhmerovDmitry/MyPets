//
//  PetInfoCollectionCell.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 13.08.2021.
//

import UIKit

final class PetInfoCollectionCell: UICollectionViewCell {
    // MARK: - Initialization & Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
}

// MARK: - Setup UI
extension PetInfoCollectionCell {
    private func setupUI() {
        self.backgroundColor = .white
        self.setDefaultShadow()
    }
}

//
//  OnboardViewController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 11.10.2020.
//

import UIKit
import SwiftUI

class OnboardViewController: UIViewController {
    private let descs = [
        "Вся информация о питомце всегда под рукой",
        "Вы не забудите купить корм или сделать прививку",
        "Выбирайте, куда сходить с любимым питомцем",
        "Советы и рекомендации по уходу за питомцем"
    ]
    private let imgs = [
        "onboardImage_1",
        "onboardImage_2",
        "onboardImage_3",
        "onboardImage_4"
    ]
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isPagingEnabled = true
        cv.backgroundColor = .white
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(OnboardViewCell.self, forCellWithReuseIdentifier: "cellId")
        
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}

//MARK: - Canvas settings
struct MyProvider: PreviewProvider {
    static var previews: some View {
        ContianerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContianerView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> some AuthorizationViewController {
            return AuthorizationViewController()
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
    }
}

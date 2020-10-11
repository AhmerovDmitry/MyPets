//
//  OnboardViewController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 11.10.2020.
//

import UIKit
import SwiftUI

class OnboardViewController: UIViewController {
//    private let mainStackView = UIStackView()
//    private let pageControl = UIPageControl()
//    private let doneButton = UIButton(type: .system)
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
//        setup()
        view.backgroundColor = .white
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
//    func setup() {
//        setupConstraint()
//        setupViewsAndLabels()
//    }
//
//    func setupConstraint() {
//        view.addSubview(mainStackView)
//        [pageControl, doneButton].forEach({ mainStackView.addArrangedSubview($0) })
//
//        mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 284).isActive = true
//        mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//
//        pageControl.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        pageControl.heightAnchor.constraint(equalToConstant: 8).isActive = true
//
//        doneButton.widthAnchor.constraint(equalToConstant: 311).isActive = true
//        doneButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
//    }
//
//    func setupViewsAndLabels() {
//        [mainStackView,
//         pageControl,
//         doneButton].forEach({
//            $0.translatesAutoresizingMaskIntoConstraints = false
//        })
//
//        mainStackView.axis = .vertical
//        mainStackView.alignment = .center
//        mainStackView.spacing = 16
//        mainStackView.setCustomSpacing(32, after: pageControl)
//
//        pageControl.currentPage = 0
//        pageControl.numberOfPages = 4
//        pageControl.currentPageIndicatorTintColor = UIColor.CustomColor.purple
//        pageControl.pageIndicatorTintColor = UIColor.CustomColor.lightGray
//
//        doneButton.setTitle("Далее", for: .normal)
//        doneButton.backgroundColor = .white
//        doneButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
//        doneButton.setTitleColor(UIColor.CustomColor.purple, for: .normal)
//        doneButton.layer.borderWidth = 1
//        doneButton.layer.borderColor = UIColor.CustomColor.purple.cgColor
//        doneButton.layer.cornerRadius = 25
//    }
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

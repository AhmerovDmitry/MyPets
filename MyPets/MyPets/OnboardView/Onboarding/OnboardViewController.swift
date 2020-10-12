//
//  OnboardViewController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 11.10.2020.
//

import UIKit
import SwiftUI

class OnboardViewController: UIViewController, OnboardViewControllerProtocol {
    private let mainStackView = UIStackView()
    lazy var pageControl = UIPageControl()
    let doneButton = UIButton(type: .system)
    let closeButton = UIButton(type: .system)
    let models = [
        OnboardModel(image: "onboardImage_1", text: "Вся информация о питомце всегда под рукой"),
        OnboardModel(image: "onboardImage_2", text: "Вы не забудите купить корм или сделать прививку"),
        OnboardModel(image: "onboardImage_3", text: "Выбирайте, куда сходить с любимым питомцем"),
        OnboardModel(image: "onboardImage_4", text: "Советы и рекомендации по уходу за питомцем")
    ]
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isScrollEnabled = false
        cv.isPagingEnabled = true
        cv.backgroundColor = .white
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(OnboardViewCell.self, forCellWithReuseIdentifier: "cellId")
        
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        setup()
    }
    
    func setup() {
        setupConstraint()
        setupViewsAndLabels()
    }
    
    func setupConstraint() {
        view.addSubview(mainStackView)
        view.addSubview(closeButton)
        [pageControl, doneButton].forEach({ mainStackView.addArrangedSubview($0) })
        
        mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 142).isActive = true
        mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        pageControl.widthAnchor.constraint(equalToConstant: 50).isActive = true
        pageControl.heightAnchor.constraint(equalToConstant: 8).isActive = true
        
        doneButton.widthAnchor.constraint(equalToConstant: 311).isActive = true
        doneButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        closeButton.topAnchor.constraint(lessThanOrEqualTo: view.topAnchor, constant: 60).isActive = true
        closeButton.rightAnchor.constraint(lessThanOrEqualTo: view.rightAnchor, constant: -32).isActive = true
        closeButton.widthAnchor.constraint(lessThanOrEqualToConstant: 97).isActive = true
        closeButton.heightAnchor.constraint(lessThanOrEqualToConstant: 21).isActive = true
    }
    
    func setupViewsAndLabels() {
        [mainStackView,
         pageControl,
         doneButton,
         closeButton].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
         })
        
        mainStackView.axis = .vertical
        mainStackView.alignment = .center
        mainStackView.spacing = 16
        mainStackView.setCustomSpacing(32, after: pageControl)
        
        pageControl.currentPage = 0
        pageControl.numberOfPages = models.count
        pageControl.currentPageIndicatorTintColor = UIColor.CustomColor.purple
        pageControl.pageIndicatorTintColor = UIColor.CustomColor.lightGray
        
        doneButton.setTitle("Далее", for: .normal)
        doneButton.backgroundColor = .white
        doneButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        doneButton.setTitleColor(UIColor.CustomColor.purple, for: .normal)
        doneButton.layer.borderWidth = 1
        doneButton.layer.borderColor = UIColor.CustomColor.purple.cgColor
        doneButton.layer.cornerRadius = 25
        doneButton.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        
        closeButton.setTitle("Пропустить", for: .normal)
        closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        closeButton.setTitleColor(UIColor.CustomColor.purple, for: .normal)
        closeButton.addTarget(self, action: #selector(presentController), for: .touchUpInside)
    }
    
    deinit {
        print("OnboardViewController - deinit")
    }
}

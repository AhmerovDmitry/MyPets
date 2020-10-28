//
//  OnboardViewController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 11.10.2020.
//

import UIKit

class OnboardViewController: UIViewController, GeneralSetupProtocol {
    let models = [
        OnboardModel(image: "onboardImage_1", text: "Вся информация о питомце всегда под рукой"),
        OnboardModel(image: "onboardImage_2", text: "Вы не забудете купить корм или сделать прививку"),
        OnboardModel(image: "onboardImage_3", text: "Выбирайте, куда сходить с любимым питомцем"),
        OnboardModel(image: "onboardImage_4", text: "Советы и рекомендации по уходу за питомцем")
    ]
    private let mainStackView = UIStackView()
    let pageControl = UIPageControl()
    let doneButton = UIButton(type: .system)
    let closeButton = UIButton(type: .system)
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
        
        setupConstraint()
        setupViewsAndLabels()
    }
    
    func setupConstraint() {
        view.addSubview(collectionView)
        view.addSubview(mainStackView)
        view.addSubview(closeButton)
        
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        [pageControl,
         doneButton].forEach({ mainStackView.addArrangedSubview($0) })
        
        mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor,
                                               constant: 142).isActive = true
        mainStackView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mainStackView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        doneButton.leftAnchor.constraint(equalTo: collectionView.leftAnchor,
                                         constant: 32).isActive = true
        doneButton.rightAnchor.constraint(equalTo: collectionView.rightAnchor,
                                          constant: -32).isActive = true
        doneButton.addConstraint(NSLayoutConstraint(item: doneButton,
                                                    attribute: .width,
                                                    relatedBy: .equal,
                                                    toItem: doneButton,
                                                    attribute: .height,
                                                    multiplier: 6,
                                                    constant: 0))
        
        closeButton.widthAnchor.constraint(lessThanOrEqualToConstant: 97).isActive = true
        closeButton.heightAnchor.constraint(lessThanOrEqualToConstant: 21).isActive = true
        closeButton.topAnchor.constraint(lessThanOrEqualTo: view.topAnchor,
                                         constant: 60).isActive = true
        closeButton.rightAnchor.constraint(lessThanOrEqualTo: view.rightAnchor,
                                           constant: -15).isActive = true
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
        mainStackView.spacing = 32
        
        pageControl.currentPage = 0
        pageControl.numberOfPages = models.count
        pageControl.currentPageIndicatorTintColor = UIColor.CustomColor.purple
        pageControl.pageIndicatorTintColor = UIColor.CustomColor.gray
        if #available(iOS 14.0, *) {
            pageControl.backgroundStyle = .minimal
        } else {
            // Fallback on earlier versions
        }
        
        doneButton.layoutIfNeeded()
        doneButton.setTitle("Далее", for: .normal)
        doneButton.backgroundColor = .white
        doneButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        doneButton.setTitleColor(UIColor.CustomColor.purple, for: .normal)
        doneButton.layer.borderWidth = 1
        doneButton.layer.borderColor = UIColor.CustomColor.purple.cgColor
        doneButton.titleLabel?.adjustsFontSizeToFitWidth = true
        doneButton.layer.cornerRadius = doneButton.frame.height / 2
        doneButton.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        
        closeButton.setTitle("Пропустить", for: .normal)
        closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        closeButton.setTitleColor(UIColor.CustomColor.purple, for: .normal)
        closeButton.addTarget(self, action: #selector(presentController), for: .touchUpInside)
    }
}

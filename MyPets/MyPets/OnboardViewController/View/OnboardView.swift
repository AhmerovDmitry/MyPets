//
//  OnboardView.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 03.08.2021.
//

import UIKit

final class OnboardView: UIView {
    // MARK: - Initialization & Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        doneButton.layer.cornerRadius = doneButton.bounds.height / 2
    }
    
    // MARK: - Properties
    public var presentControllerCallBack: (() -> Void)?
    private var onboardImage: [String]?
    private var onboardDescription: [String]?
    private let cellID = "OnboardCellId"
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = UIColor.CustomColor.purple
        pageControl.pageIndicatorTintColor = UIColor.CustomColor.gray
        if #available(iOS 14.0, *) {
            pageControl.backgroundStyle = .minimal
        }
        return pageControl
    }()
    private let doneButton = UIButton.createStandartButton(
        title: "Далее", backgroundColor: .white, action: #selector(nextDescriptionView), target: self
    )
    private let skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Пропустить", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        button.setTitleColor(UIColor.CustomColor.purple, for: .normal)
        button.addTarget(self, action: #selector(presentController), for: .touchUpInside)
        return button
    }()
    private lazy var onboardCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: self.bounds.width, height: self.bounds.height)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(OnboardCollectionCell.self, forCellWithReuseIdentifier: cellID)
        return collectionView
    }()
}

// MARK: - Setup UI
extension OnboardView {
    private func setupUI() {
        self.backgroundColor = .white
        setOnboardCollectionViewConstraints()
        setPageControlConstraints()
        setDoneButtonConstraints()
        setCloseButtonConstraints()
    }
    private func setOnboardCollectionViewConstraints() {
        self.addSubview(onboardCollectionView)
        onboardCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            onboardCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            onboardCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            onboardCollectionView.leftAnchor.constraint(equalTo: self.leftAnchor),
            onboardCollectionView.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }
    private func setPageControlConstraints() {
        self.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pageControl.heightAnchor.constraint(equalToConstant: 10),
            pageControl.widthAnchor.constraint(equalTo: self.widthAnchor),
            pageControl.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            pageControl.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: self.bounds.height * 0.06 + 16)
        ])
    }
    private func setDoneButtonConstraints() {
        self.addSubview(doneButton)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            doneButton.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 32),
            doneButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.06),
            doneButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            doneButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    private func setCloseButtonConstraints() {
        self.addSubview(skipButton)
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            skipButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            skipButton.rightAnchor.constraint(lessThanOrEqualTo: self.rightAnchor, constant: -32)
        ])
    }
}

// MARK: - Actions
extension OnboardView {
    @objc private func nextDescriptionView() {
        let nextIndex = pageControl.currentPage + 1
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        onboardCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        if nextIndex == 3 {
            doneButton.removeTarget(nil, action: nil, for: .allEvents)
            doneButton.setTitle("Приступим!", for: .normal)
            doneButton.backgroundColor = UIColor.CustomColor.purple
            doneButton.setTitleColor(.white, for: .normal)
            doneButton.addTarget(self, action: #selector(presentController), for: .touchUpInside)
            skipButton.isHidden = true
        }
    }
    @objc private func presentController(_ parent: UIViewController) {
        presentControllerCallBack?()
    }
}

// MARK: - Delegate & DataSource
extension OnboardView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pageControl.numberOfPages
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: cellID,
            for: indexPath
        ) as? OnboardCollectionCell else { return UICollectionViewCell() }
        cell.configureCell(
            image: onboardImage?[indexPath.item] ?? "",
            description: onboardDescription?[indexPath.item] ?? ""
        )
        return cell
    }
}

// MARK: - Public Methods
extension OnboardView {
    public func getOnboardContent(_ content: Any) {
        guard let content = content as? OnboardModel else { return }
        pageControl.numberOfPages = content.description.count
        onboardImage = content.imagesName
        onboardDescription = content.description
    }
}

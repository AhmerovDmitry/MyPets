//
//  MainMenuView.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 11.08.2021.
//

import UIKit

final class MainMenuView: UIView {

    // MARK: - LayoutSubviews
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }

    // MARK: - Properties
    let weatherMenuView = WeatherMenuView()
    private let titleMenuView = TitleMenuView()
    private let cellID = "MainMenuCell"
    private lazy var generalMenuCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = self.bounds.width - (self.bounds.width / 1.11111)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        return collectionView
    }()
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = UIColor.CustomColor.purple
        pageControl.pageIndicatorTintColor = UIColor.CustomColor.gray
        pageControl.numberOfPages = 5
        if #available(iOS 14.0, *) {
            pageControl.backgroundStyle = .minimal
        }
        return pageControl
    }()
}

// MARK: - Setup UI
extension MainMenuView {
    private func setupUI() {
        self.backgroundColor = .white
        setTitleMenuViewConstraints()
        setWeatherMenuViewConstraints()
        setPageControlConstraints()
        setGeneralMenuCollectionViewConstraints()
    }
    private func setTitleMenuViewConstraints() {
        self.addSubview(titleMenuView)
        titleMenuView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleMenuView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 12),
            titleMenuView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleMenuView.heightAnchor.constraint(equalToConstant: self.bounds.height / 6),
            titleMenuView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9)
        ])
    }
    private func setWeatherMenuViewConstraints() {
        self.addSubview(weatherMenuView)
        weatherMenuView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherMenuView.topAnchor.constraint(equalTo: titleMenuView.bottomAnchor, constant: 12),
            weatherMenuView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            weatherMenuView.heightAnchor.constraint(equalToConstant: self.bounds.height / 6),
            weatherMenuView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9)
        ])
    }
    private func setGeneralMenuCollectionViewConstraints() {
        self.addSubview(generalMenuCollectionView)
        generalMenuCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            generalMenuCollectionView.topAnchor.constraint(equalTo: weatherMenuView.bottomAnchor),
            generalMenuCollectionView.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: 12),
            generalMenuCollectionView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            generalMenuCollectionView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }
    private func setPageControlConstraints() {
        self.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageControl.heightAnchor.constraint(equalToConstant: 36),
            pageControl.widthAnchor.constraint(equalTo: self.widthAnchor),
            pageControl.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - Delegate & DataSource
extension MainMenuView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: (self.bounds.width - (self.bounds.width / 1.11111)) / 2,
                            bottom: 0, right: (self.bounds.width - (self.bounds.width / 1.11111)) / 2)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: weatherMenuView.bounds.width, height: collectionView.bounds.height - 24)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        cell.setDefaultShadow()
        cell.backgroundColor = UIColor.CustomColor.lightGray
        cell.layer.cornerRadius = 16
        return cell
    }
}

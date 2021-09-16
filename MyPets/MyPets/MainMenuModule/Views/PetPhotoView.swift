//
//  PetPhotoView.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 16.09.2021.
//

import UIKit

final class PetPhotoView: UIView {
    private let petPhotoCellID = "MainMenuCell"
    private lazy var petPhotoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = self.bounds.width - UIView.ninePartsScreenMultiplier
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: petPhotoCellID)
        return collectionView
    }()
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = UIColor.CustomColor.purple
        pageControl.pageIndicatorTintColor = UIColor.CustomColor.gray
        pageControl.isEnabled = false
        if #available(iOS 14.0, *) {
            pageControl.backgroundStyle = .minimal
        }
        return pageControl
    }()
}

extension PetPhotoView {
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }
    private func setupUI() {
        setPageControlConstraints()
        setPetPhotoCollectionViewConstraints()
    }
    private func setPetPhotoCollectionViewConstraints() {
        self.addSubview(petPhotoCollectionView)
        petPhotoCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            petPhotoCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            petPhotoCollectionView.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: 12),
            petPhotoCollectionView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            petPhotoCollectionView.widthAnchor.constraint(equalTo: self.widthAnchor)
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

extension PetPhotoView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: (self.bounds.width - (UIView.ninePartsScreenMultiplier)) / 2,
                            bottom: 0, right: (self.bounds.width - (UIView.ninePartsScreenMultiplier)) / 2)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIView.ninePartsScreenMultiplier, height: collectionView.bounds.height - 24)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageControl.numberOfPages = 5
        return pageControl.numberOfPages
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: petPhotoCellID, for: indexPath)
        cell.setDefaultShadow()
        cell.backgroundColor = UIColor.CustomColor.lightGray
        cell.layer.cornerRadius = UIView.basicCornerRadius
        return cell
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}

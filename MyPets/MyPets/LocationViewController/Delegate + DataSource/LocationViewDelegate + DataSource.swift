//
//  LocationViewControllerDelegate + DataSource.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 22.10.2020.
//

import UIKit

extension LocationViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = models[indexPath.row]
        var itemSize = CGSize()
        if let buttonText = item.secondProperties {
            itemSize = buttonText.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)])
        }
        
        return CGSize(width: itemSize.width + 50, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellFilterId", for: indexPath) as! LocationViewCell
        let data = models[indexPath.item]
        cell.model = data
        
        switch indexPath.item {
        case 0:
            cell.valueButton.addTarget(self, action: #selector(response0), for: .touchUpInside)
        case 1:
            cell.valueButton.addTarget(self, action: #selector(response1), for: .touchUpInside)
        case 2:
            cell.valueButton.addTarget(self, action: #selector(response2), for: .touchUpInside)
        case 3:
            cell.valueButton.addTarget(self, action: #selector(response3), for: .touchUpInside)
        case 4:
            cell.valueButton.addTarget(self, action: #selector(response4), for: .touchUpInside)
        case 5:
            cell.valueButton.addTarget(self, action: #selector(response5), for: .touchUpInside)
        case 6:
            cell.valueButton.addTarget(self, action: #selector(response6), for: .touchUpInside)
        case 7:
            cell.valueButton.addTarget(self, action: #selector(response7), for: .touchUpInside)
        default:
            break
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    @objc func response0() {
    }
    @objc func response1() {
        searchInMap(place: models[1].secondProperties)
    }
    @objc func response2() {
        searchInMap(place: models[2].secondProperties)
    }
    @objc func response3() {
        searchInMap(place: models[3].secondProperties)
    }
    @objc func response4() {
        searchInMap(place: models[4].secondProperties)
    }
    @objc func response5() {
        searchInMap(place: models[5].secondProperties)
    }
    @objc func response6() {
        searchInMap(place: models[6].secondProperties)
    }
    @objc func response7() {
        searchInMap(place: models[7].secondProperties)
    }
}

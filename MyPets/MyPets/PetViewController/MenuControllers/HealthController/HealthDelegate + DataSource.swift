//
//  HealthDelegate + DataSource.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 05.03.2021.
//

import UIKit

extension HealthController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width / 1.1, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "healthCellId", for: indexPath) as! MenuCell
        cell.titleImage.image = UIImage(named: "healthIcon")
        cell.menuTitleLabel.text = models[indexPath.item].firstProperties
        cell.descLabel.text = models[indexPath.item].secondProperties
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controllers = [ClinicVC(), DewormingVC(), TreatmentVC(), VaccinationVC(), DiseasesVC()]
        controllers[indexPath.item].modalPresentationStyle = .fullScreen
        
        present(controllers[indexPath.item], animated: true, completion: nil)
    }
}

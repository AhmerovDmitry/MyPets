//
//  @objc OnboardViewControllerExtension.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 11.10.2020.
//

import UIKit

@objc
extension OnboardViewController {
    func handleNext() {
        let nextIndex = min(pageControl.currentPage + 1, models.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        if nextIndex == 3 {
            doneButton.removeTarget(nil, action: nil, for: .allEvents)
            doneButton.setTitle("Приступим!", for: .normal)
            doneButton.backgroundColor = UIColor.CustomColor.purple
            doneButton.setTitleColor(.white, for: .normal)
            doneButton.addTarget(self, action: #selector(presentController), for: .touchUpInside)
        }
    }
    @objc func presentController() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        
        let premiumVC = PremiumViewController()
        premiumVC.modalPresentationStyle = .fullScreen
        present(premiumVC, animated: false, completion: nil)
    }
}

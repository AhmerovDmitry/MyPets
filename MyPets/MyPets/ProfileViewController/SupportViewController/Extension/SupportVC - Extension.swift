//
//  SupportVC - Extension.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 31.01.2021.
//

import MessageUI

extension SupportViewController: MFMailComposeViewControllerDelegate {
    func sendRequest(toMail: String) {
        if !MFMailComposeViewController.canSendMail() {
            print("Mail services are not available")
            return
        } else {
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = self
            composeVC.setToRecipients([toMail])
            composeVC.setSubject("MyPets request")
            composeVC.setMessageBody("Опишите ситуацию как можно подробнее:", isHTML: false)
             
            self.present(composeVC, animated: true, completion: nil)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}

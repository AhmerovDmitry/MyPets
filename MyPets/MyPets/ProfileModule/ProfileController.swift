//
//  ProfileController.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 12.09.2021.
//

import UIKit
import MessageUI

protocol ProfileViewDelegate: AnyObject {
    func userRemoveObject()
}

protocol SystemViewResetButtonsDelegate: AnyObject {
    func resetLaunchStatus()
    func resetPurchaseStatus()
}

final class ProfileController: UIViewController {

    // MARK: - Property

    private let storageService: StorageService
    private let userDefaultsService: UserDefaultsService

    private let profileModel: ProfileModelProtocol
    private let profileView: ProfileView
    private var systemView: SystemView
    private var systemTableView: UITableView?

    private let profileTableViewCellID = "profileTableViewCellID"
    private var systemViewIsHidden = true

    // MARK: - Init / Lifecycle

    init(storageService: StorageService, userDefaultsService: UserDefaultsService) {
        self.storageService = storageService
        self.userDefaultsService = userDefaultsService
        self.profileModel = ProfileModel()
        self.profileView = ProfileView(frame: UIScreen.main.bounds)
        self.systemView = SystemView(userDefaultsService: userDefaultsService)
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func loadView() {
        view = profileView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        systemView.delegate = self
        setupNavigationController()
        profileView.tableViewDelegateAndDataSource(self)
        profileView.setTableViewID(profileTableViewCellID)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        systemViewIsHidden = true
        systemTableView?.tableFooterView = nil
    }

    // MARK: - UI

    private func setupNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.CustomColor.dark]
        navigationItem.title = profileModel.controllerTitle
    }
}

// MARK: - Methods

extension ProfileController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return profileModel.profileTableViewSectionBody.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileModel.profileTableViewSectionBody[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: profileTableViewCellID, for: indexPath)
        cell.textLabel?.text = profileModel.profileTableViewSectionBody[indexPath.section][indexPath.row]
        cell.imageView?.image = profileModel.profileTableViewSectionImages[indexPath.section]
        cell.imageView?.tintColor = UIColor.CustomColor.darkGray
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        systemTableView = tableView
        userTappedCell(section: indexPath.section, row: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ProfileController {
    private func userTappedCell(section: Int, row: Int) {
        switch section {
        case 0: presentEntitysController()
        case 1: presentPremiumController()
        case 2:
            switch row {
            case 0: sendRequest(toMail: "ahmerov.dmitry@gmail.com")
            case 1:
                let bundle = Bundle.main
                guard let appVersion = bundle.infoDictionary?["CFBundleShortVersionString"] as? String else { return }
                guard let appBuildVersion = bundle.infoDictionary?["CFBundleVersion"] as? String else { return }
                UIAlertController.presentAlertWithBasicType(
                    self,
                    title: "Версия приложения:",
                    message: appVersion + "." + appBuildVersion,
                    style: .alert
                )
            default: break
            }
        case 3:
            if systemViewIsHidden {
                systemViewIsHidden = false
                systemTableView?.tableFooterView = systemView
            } else {
                systemViewIsHidden = true
                systemTableView?.tableFooterView = nil
            }
        default: break
        }
    }
    private func presentEntitysController() {
        if !storageService.objects.isEmpty {
            let entitysController = EntitysController(storageService: storageService)
            navigationController?.pushViewController(entitysController, animated: true)
        }
    }
    private func presentPremiumController() {
        let premiumController = PremiumController(userDefaultsService: userDefaultsService)
        premiumController.modalPresentationStyle = .fullScreen
        self.present(premiumController, animated: true, completion: nil)
    }
}

extension ProfileController: SystemViewResetButtonsDelegate {
    func resetLaunchStatus() {
        userDefaultsService.setValue(false, forKey: .isNotFirstLaunch)
        debugPrint("Статус запуска приложения сброшен")
    }
    func resetPurchaseStatus() {
        userDefaultsService.setValue(false, forKey: .isAppPurchased)
        debugPrint("Статус покупки приложения сброшен")
    }
}

extension ProfileController: MFMailComposeViewControllerDelegate {
    private func sendRequest(toMail: String) {
        if !MFMailComposeViewController.canSendMail() {
            UIAlertController.presentAlertWithBasicType(
                self,
                title: "Ошибка при открытии почтового клиента",
                message: "Ваше устройство не может отправить письмо из этого приложение"
                    + "\nВы всегда можете воспользоваться другим приложением и отправить письмо на адрес"
                    + "\nmypetsdev@gmail.com",
                style: .alert
            )
        } else {
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = self
            composeVC.setToRecipients([toMail])
            composeVC.setSubject("MyPets Request")
            composeVC.setMessageBody("Опишите проблему с которой вы столкнулись:", isHTML: false)
            present(composeVC, animated: true, completion: nil)
        }
    }
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult,
                               error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}

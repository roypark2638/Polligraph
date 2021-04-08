//
//  NotificationViewController.swift
//  Polligraph
//
//  Created by Roy Park on 3/3/21.
//

import UIKit

class NotificationViewController: UIViewController {
    
    // MARK: - Properties
    
    struct Constants {
        static let padding: CGFloat = 70
    }
    
    private let alertsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Alerts", for: .normal)
        button.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 18)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let inboxButton: UIButton = {
        let button = UIButton()
        button.setTitle("Inbox", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 18)
        return button
    }()
    
    private let noNotificationLabel: UILabel = {
        let label = UILabel()
        label.text = "No new alerts."
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Regular", size: 18)
        label.textColor = .secondaryLabel
        label.isHidden = false
        label.textAlignment = .center
        return label
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        
        collectionView.register(
            UICollectionViewCell.self,
            forCellWithReuseIdentifier: "cell"
        )
//        collectionView.register(
//            NotificationTabsCollectionReusableView.self,
//            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
//            withReuseIdentifier: NotificationTabsCollectionReusableView.identifier
//        )
        collectionView.backgroundColor = .systemBackground
        collectionView.showsVerticalScrollIndicator = false
        // when it's empty, default tableView is hidden
        collectionView.isHidden = false
        return collectionView
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.tintColor = .label
        spinner.startAnimating()
        return spinner
    }()
    
    var notifications = [Notification]()
    
    // MARK:- LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        addSubviews()
        configureLayouts()
        configureButton()
//        fetchNotificationData()
        updateUI()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    // MARK: - Methods
    
    private func fetchNotificationData() {
//        DatabaseManager.shared.getNotifications { [weak self] (notifications) in
//            DispatchQueue.main.async {
//                self?.spinner.stopAnimating()
//                self?.spinner.isHidden = true
//                self?.notifications = notifications
//                self?.updateUI()
//            }
//        }
    }
    
    private func updateUI() {
        if notifications.isEmpty {
            noNotificationLabel.isHidden = false
            collectionView.isHidden = true
        }
        else {
            noNotificationLabel.isHidden = true
            collectionView.isHidden = false
        }
        
        collectionView.reloadData()
    }
    
    private func addSubviews() {
        view.addSubview(noNotificationLabel)
        view.addSubview(collectionView)
        view.addSubview(alertsButton)
        view.addSubview(inboxButton)
    }
    
    private func configureLayouts() {
        collectionView.frame = view.bounds
        
        alertsButton.sizeToFit()
        let alertsButtonX = ((view.width/2)-alertsButton.width)/2
        alertsButton.frame = CGRect(
            x: alertsButtonX,
            y: Constants.padding,
            width: alertsButton.width,
            height: alertsButton.height
        )
        
        inboxButton.sizeToFit()
        inboxButton.frame = CGRect(
            x: alertsButtonX + (view.width / 2),
            y: Constants.padding,
            width: inboxButton.width,
            height: inboxButton.height
        )
        
        noNotificationLabel.sizeToFit()
        noNotificationLabel.frame = CGRect(
            x: (view.width-noNotificationLabel.width)/2,
            y: view.safeAreaInsets.top + 150,
            width: noNotificationLabel.width,
            height: noNotificationLabel.height
        )
    }
    
    private func configureButton() {
        alertsButton.addTarget(
            self,
            action: #selector(didTapAlert),
            for: .touchUpInside
        )
        
        inboxButton.addTarget(
            self,
            action: #selector(didTapInbox),
            for: .touchUpInside
        )
    }
    
    @objc private func didTapAlert() {
        
    }
    
    @objc private func didTapInbox() {
        
    }
}

extension NotificationViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int
    ) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .systemBlue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: view.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 1
    }
//
//    func collectionView(_ collectionView: UICollectionView,
//                        viewForSupplementaryElementOfKind kind: String,
//                        at indexPath: IndexPath
//    ) -> UICollectionReusableView {
//        guard kind == UICollectionView.elementKindSectionHeader else {
//            return UICollectionReusableView()
//        }
//
        // tabs header
//        let tabControlHeader = collectionView.dequeueReusableSupplementaryView(
//            ofKind: kind,
//            withReuseIdentifier: NotificationTabsCollectionReusableView.identifier,
//            for: indexPath
//        ) as! NotificationTabsCollectionReusableView
//        return tabControlHeader
//
//        return UICollectionReusableView()
//
//    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        return CGSize(
            width: view.width,
            height: 56
        )
        
        
    }
}

//
//  NotificationViewController.swift
//  Polligraph
//
//  Created by Roy Park on 3/3/21.
//

import UIKit

enum NotificationPages: Int {
    case alerts
    case inbox
    
    var identifier: String {
        switch self {
        case .alerts: return "Alerts"
        case .inbox: return "Inbox"
        }
    }
    
    static func pagesToShow() -> [NotificationPages] {
        return [.alerts, .inbox]
    }
}

class NotificationViewController: UIViewController {
    
    // MARK: - Properties
    
    fileprivate var currentIndex = 0
    
    private let control : UISegmentedControl = {
        let titles = ["Alert", "Inbox"]
        let control = UISegmentedControl(items: titles)
        control.backgroundColor = .clear
        control.selectedSegmentTintColor = .label
        control.selectedSegmentIndex = 0
        return control
    }()
    
//    struct Constants {
//        static let padding: CGFloat = 70
//    }
    
//    private let alertsButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("Alerts", for: .normal)
//        button.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 18)
//        button.setTitleColor(.label, for: .normal)
//        return button
//    }()
//
//    private let inboxButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("Inbox", for: .normal)
//        button.setTitleColor(.secondaryLabel, for: .normal)
//        button.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 18)
//        return button
//    }()
    

    
//    private let collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        let collectionView = UICollectionView(
//            frame: .zero,
//            collectionViewLayout: layout
//        )
//
//        collectionView.register(
//            UICollectionViewCell.self,
//            forCellWithReuseIdentifier: "cell"
//        )
////        collectionView.register(
////            NotificationTabsCollectionReusableView.self,
////            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
////            withReuseIdentifier: NotificationTabsCollectionReusableView.identifier
////        )
//        collectionView.backgroundColor = .systemBackground
//        collectionView.showsVerticalScrollIndicator = false
//        // when it's empty, default tableView is hidden
//        collectionView.isHidden = false
//        return collectionView
//    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.tintColor = .label
        spinner.startAnimating()
        return spinner
    }()
    
    private let codeSegmented = CustomSegmentedControl(
        frame: .zero,
        buttonTitles: ["Alerts", "Inbox"]
    )

//    var notifications = [Alert]()
    
    // MARK:- LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        codeSegmented.backgroundColor = .clear
        self.navigationController?.navigationBar.layer.zPosition = -1
        self.navigationController?.navigationBar.isUserInteractionEnabled = false
        view.addSubview(codeSegmented)
//        let vc = AlertViewController()
//        let nav = UINavigationController(rootViewController: vc)
//        nav.navigationBar.isTranslucent = false
//        nav.navigationBar.shadowImage = UIImage()
//        nav.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        nav.modalPresentationStyle = .currentContext
//        tabBarController?.hidesBottomBarWhenPushed = false
//        present(nav, animated: false, completion: nil)
//        navigationController?.pushViewController(vc, animated: true)
//        addSubviews()
//        configureLayouts()
//        configureButton()
//        fetchNotificationData()
        
//        collectionView.delegate = self
//        collectionView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        codeSegmented.frame = CGRect(
            x: 0,
            y: 50,
            width: view.width,
            height: 50
        )
    }
    
    // MARK: - Methods
    

    
   
    
    @objc private func didTapAlert() {
        
    }
    
    @objc private func didTapInbox() {
        
    }
}

// MARK: - UICollectionViewDataSource

//extension NotificationViewController: UICollectionViewDataSource {
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView,
//                        numberOfItemsInSection section: Int
//    ) -> Int {
//        return notifications.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView,
//                        cellForItemAt indexPath: IndexPath
//    ) -> UICollectionViewCell {
//        let model = notifications[indexPath.row]
        
//        switch model.type {
//        case .userFollow(let username):
//            guard let cell = collectionView.dequeueReusableCell(
//                withReuseIdentifier: AlertUserFollowTableViewCell.identifier,
//                for: indexPath
//            ) as? AlertUserFollowTableViewCell else {
//                let defaultCell = collectionView.dequeueReusableCell(
//                    withReuseIdentifier: "cell",
//                    for: indexPath
//                )
//                return defaultCell
//            }
//            cell.configure(with: username)
//            return cell
//
//        case .postComment(let postName):
////            guard let cell = collectionView.dequeueReusableCell(
////                withReuseIdentifier: NotificationPostCommentCollectionViewCell.identifier,
////                    for: <#T##IndexPath#>
////            )
//        break
//        case .postCommentLike(let postName):
//            break
//        }
//
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
//        cell.backgroundColor = .systemBlue
//        return cell
//    }
//
//
//}

// MARK: - UICollectionViewDelegate

//extension NotificationViewController: UICollectionViewDelegate {
//
//}

// MARK: - UICollectionViewDelegateFlowLayout
//extension NotificationViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath
//    ) -> CGSize {
//        return CGSize(width: view.width, height: 40)
//    }
//
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        minimumLineSpacingForSectionAt section: Int
//    ) -> CGFloat {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        minimumInteritemSpacingForSectionAt section: Int
//    ) -> CGFloat {
//        return 1
//    }
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
//
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        referenceSizeForHeaderInSection section: Int
//    ) -> CGSize {
//        return CGSize(
//            width: view.width,
//            height: 56
//        )
//
//
//    }
//}

// MARK: -

//extension NotificationViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//
//    }
//
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//
//    }
//
//
//}

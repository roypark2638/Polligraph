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

    private let pageContainer = UIView()
    private let pageVC = UIPageViewController()
        
    private let alertVC = AlertViewController()
    private let inboxVC = InboxViewController()
    
    private let orderedVC = [AlertViewController(), InboxViewController()]
    
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
        view.addSubview(codeSegmented)
        view.addSubview(pageContainer)
        pageContainer.addSubview(pageVC.view)
        codeSegmented.delegate = self
        pageVC.dataSource = self
                
        pageVC.setViewControllers(
            [alertVC],
            direction: UIPageViewController.NavigationDirection.reverse,
            animated: true,
            completion: nil
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.layer.zPosition = -1
        self.navigationController?.navigationBar.isUserInteractionEnabled = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        codeSegmented.frame = CGRect(
            x: 0,
            y: 50+20,
            width: view.width,
            height: 50
        )
        
        pageContainer.frame = CGRect(
            x: 0,
            y: codeSegmented.bottom+2,
            width: view.width,
            height: view.height-50 - 86
        )
        
        pageVC.view.frame = CGRect(
            x: 0,
            y: 0,
            width: pageContainer.width,
            height: pageContainer.height
        )
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.navigationBar.layer.zPosition = 0
        self.navigationController?.navigationBar.isUserInteractionEnabled = true
    }
    
}

// MARK: - UIPageViewControllerDataSource

extension NotificationViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = orderedVC.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = vcIndex - 1
        
        guard previousIndex >= 0 else { return nil }
        
        return orderedVC[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = orderedVC.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = vcIndex + 1
        guard orderedVC.count != nextIndex,
              orderedVC.count > nextIndex
              else { return nil }
        
        return orderedVC[nextIndex]
    }
    
}

// MARK: - CustomSegmentedControlDelegate

extension NotificationViewController: CustomSegmentedControlDelegate {
    func customSegmentedControlDidTapButton(_ control: CustomSegmentedControl, sender: UIButton) {
        guard let title = sender.titleLabel?.text else { return }
        if title == NotificationPages.alerts.identifier {
            addChild(alertVC)
            pageContainer.addSubview(alertVC.view)
//            pageVC.setViewControllers(
//                [alertVC],
//                direction: UIPageViewController.NavigationDirection.reverse,
//                animated: false,
//                completion: nil
//            )
//            currentIndex = 0
        }
        else {
            addChild(inboxVC)
            pageContainer.addSubview(inboxVC.view)
//            pageVC.setViewControllers(
//                [inboxVC],
//                direction: UIPageViewController.NavigationDirection.forward,
//                animated: false,
//                completion: nil
//            )
//            currentIndex = 1
        }
    }
}

//
//  NewPostPageViewController.swift
//  Polligraph
//
//  Created by Roy Park on 4/27/21.
//

import UIKit

class NewPostPageViewController: UIPageViewController {
    
    var orderedViewControllers: [UIViewController] = [UIViewController]()
    
    var pagesToShow: [NewPostPages] = NewPostPages.pagesToShow()
    
    var currentIndex = 0
    
    override init(
        transitionStyle style: UIPageViewController.TransitionStyle,
        navigationOrientation: UIPageViewController.NavigationOrientation,
        options: [UIPageViewController.OptionsKey : Any]? = nil
    ) {
        super.init(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal,
            options: nil
        )
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        dataSource = self
        
        for pageToShow in pagesToShow {
            let page = newViewController(pageToShow: pageToShow)
            orderedViewControllers.append(page)
        }
        
        if let firstVC = orderedViewControllers.first {
            setViewControllers(
                [firstVC],
                direction: UIPageViewController.NavigationDirection.forward,
                animated: true,
                completion: nil
            )
        }
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(newPage(notification:)),
            name: NSNotification.Name(rawValue: "newPage"),
            object: nil
        )
        
    }
    
    @objc private func newPage(notification: NSNotification) {
        if let receivedObject = notification.object as? NewPostPages {
            showViewController(index: receivedObject.rawValue)
        }
    }


    private func newViewController(pageToShow: NewPostPages) -> UIViewController {
        switch pageToShow {
        case .library:
            return LibraryViewController()
            
        case .camera:
            return CameraViewController()
        }
    }
    
    private func showViewController(index: Int) {
        if currentIndex > index {
            setViewControllers(
                [orderedViewControllers[index]],
                direction: UIPageViewController.NavigationDirection.reverse,
                animated: true,
                completion: nil
            )
        }
        else if currentIndex < index {
            setViewControllers(
                [orderedViewControllers[index]],
                direction: UIPageViewController.NavigationDirection.forward,
                animated: true,
                completion: nil
            )
        }
        
        currentIndex = index
    }

}

extension NewPostPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedVCCount = orderedViewControllers.count
        
        guard orderedVCCount != nextIndex else {
            return nil
        }
        
        guard orderedVCCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    
}

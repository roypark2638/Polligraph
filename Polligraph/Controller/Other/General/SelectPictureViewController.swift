//
//  SelectPictureViewController.swift
//  Polligraph
//
//  Created by Roy Park on 4/27/21.
//

import UIKit


class SelectPictureViewController: UIViewController {
    
    private let pageContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private let segmentControl = CustomSegmentedControl(
        frame: .zero,
        buttonTitles: ["Library", "Camera"]
    )
    
    private var pageVC: NewPostPageViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()

        view.backgroundColor = .systemBackground
        view.addSubview(segmentControl)
        view.addSubview(pageContainerView)
        segmentControl.backgroundColor = .clear
        segmentControl.delegate = self
                
        pageVC = NewPostPageViewController()
        addChild(pageVC)
        pageVC.view.translatesAutoresizingMaskIntoConstraints = false
        pageContainerView.addSubview(pageVC.view)
        
        NSLayoutConstraint.activate([
            pageVC.view.topAnchor.constraint(equalTo: pageContainerView.topAnchor),
            pageVC.view.bottomAnchor.constraint(equalTo: pageContainerView.bottomAnchor),
            pageVC.view.leadingAnchor.constraint(equalTo: pageContainerView.leadingAnchor),
            pageVC.view.trailingAnchor.constraint(equalTo: pageContainerView.trailingAnchor)
        ])
        pageVC.didMove(toParent: self)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let segmentHeight: CGFloat = 84

        
        segmentControl.frame = CGRect(
            x: 0,
            y: view.bottom - segmentHeight,
            width: view.width,
            height: segmentHeight
        )
        
        NSLayoutConstraint.activate([
            pageContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pageContainerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            pageContainerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            pageContainerView.bottomAnchor.constraint(equalTo: segmentControl.topAnchor)
        ])
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private func configureNavigationBar() {

        navigationController?.navigationBar.tintColor = .label
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "X Icon"),
            style: .plain,
            target: self,
            action: #selector(didTapClose)
        )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Upload",
            style: .plain,
            target: self,
            action: #selector(didTapUpload)
        )
        let attribute = [NSAttributedString.Key.font: UIFont(name: "Roboto-Bold", size: 18)]
        let rightButton = self.navigationItem.rightBarButtonItem
        rightButton?.setTitleTextAttributes(attribute as [NSAttributedString.Key : Any], for: .normal)
        
    }
    
    @objc private func didTapClose() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapUpload() {
        dismiss(animated: true, completion: nil)
    }

}


extension SelectPictureViewController: CustomSegmentedControlDelegate {
    func customSegmentedControlDidTapButton(_ control: CustomSegmentedControl, sender: UIButton) {
        guard let title = sender.titleLabel?.text else { return }
        if title == NewPostPages.library.identifier {
            NotificationCenter.default.post(name: NSNotification.Name("newPage"), object: NewPostPages.library)
        }
        else if title == NewPostPages.camera.identifier {
            NotificationCenter.default.post(name: NSNotification.Name("newPage"), object: NewPostPages.camera)
        }
    }
}

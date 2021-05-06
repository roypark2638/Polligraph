//
//  CameraViewController.swift
//  Polligraph
//
//  Created by Roy Park on 3/3/21.
//

import UIKit


class CameraViewController: UIViewController {
    
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
        
        configureContainerView()
        
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
    
    private func configureContainerView() {
        
    }
    
    private func configureNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(didTapClose)
        )
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.label]
    }
    
    @objc private func didTapClose() {
        dismiss(animated: true, completion: nil)
    }

}


extension CameraViewController: CustomSegmentedControlDelegate {
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

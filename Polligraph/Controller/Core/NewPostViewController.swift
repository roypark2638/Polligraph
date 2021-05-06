//
//  CameraViewController.swift
//  Polligraph
//
//  Created by Roy Park on 4/27/21.
//

import UIKit

class NewPostViewController: UIViewController {
    
    private let textButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Text Button"), for: .normal)
        button.imageView?.clipsToBounds = true
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    private let photoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Photo Button"), for: .normal)
        button.imageView?.clipsToBounds = true
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    private let videoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Video Button"), for: .normal)
        button.imageView?.clipsToBounds = true
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    private let linkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Link Button"), for: .normal)
        button.imageView?.clipsToBounds = true
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Create Poll"
        addSubviews()
        addButtonActions()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let imageSize = CGSize(width: 86, height: 122)
        let padding = CGSize(width: 64, height: 67)
        
        textButton.frame = CGRect(
            x: (view.width - padding.width)/2 - imageSize.width,
            y: view.center.y - imageSize.height - padding.height/2,
            width: imageSize.width,
            height: imageSize.height
        )
        
        photoButton.frame = CGRect(
            x: (view.width + padding.width)/2,
            y: view.center.y - imageSize.height - padding.height/2,
            width: imageSize.width,
            height: imageSize.height
        )
        
        videoButton.frame = CGRect(
            x: (view.width - padding.width)/2 - imageSize.width,
            y: view.center.y + padding.height/2,
            width: imageSize.width,
            height: imageSize.height
        )
        
        linkButton.frame = CGRect(
            x: (view.width + padding.width)/2,
            y: view.center.y + padding.height/2,
            width: imageSize.width,
            height: imageSize.height
        )
    }
    
    private func addSubviews() {
        view.addSubview(textButton)
        view.addSubview(linkButton)
        view.addSubview(photoButton)
        view.addSubview(videoButton)
    }
    
    private func addButtonActions() {
        textButton.addTarget(self,
                             action: #selector(didTapText),
                             for: .touchUpInside)
        linkButton.addTarget(self,
                             action: #selector(didTapLink),
                             for: .touchUpInside)
        photoButton.addTarget(self,
                             action: #selector(didTapPhoto),
                             for: .touchUpInside)
        videoButton.addTarget(self,
                             action: #selector(didTapVideo),
                             for: .touchUpInside)
    }
    
    @objc private func didTapText() {
        let vc = TextPollViewController()
        navigationController?.navigationBar.tintColor = .label
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapLink() {
        let vc = LinkPollViewController()
        navigationController?.navigationBar.tintColor = .label
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapPhoto() {
        let vc = PhotoPollViewController()
        navigationController?.navigationBar.tintColor = .label
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapVideo() {
        let vc = VideoPollViewController()
        navigationController?.navigationBar.tintColor = .label
        navigationController?.pushViewController(vc, animated: true)
    }
}

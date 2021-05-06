//
//  VideoPollViewController.swift
//  Polligraph
//
//  Created by Roy Park on 5/5/21.
//

import UIKit

class VideoPollViewController: UIViewController {

    // MARK: - Subviews
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
        
    private let titleLabel = NewPostTitleLabel(title: "Title")
    private let photoLabel = NewPostTitleLabel(title: "Video")
    private let pollsLabel = NewPostTitleLabel(title: "Polls")
    private let roomsLabel = NewPostTitleLabel(title: "Rooms")
    
    private let titleTextView = NewPostTextView(type: .title)
//    private let descriptionTextView = NewPostTextView(type: .description)
    private let firstPollTextView = NewPostTextView(type: .firstPoll)
    private let secondPollTextView = NewPostTextView(type: .secondPoll)
    private let roomsTextView = NewPostTextView(type: .rooms)
    
    private let videoButton: UIButton = {
        let button = UIButton()
        button.imageView?.clipsToBounds = true
        button.setImage(UIImage(named: "Video Button (1)"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    private let titleCountLabel = TextCountLabel(count: 100)
    private let firstPollCountLabel = TextCountLabel(count: 100)
    private let secondPollCountLabel = TextCountLabel(count: 100)

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Video Poll"
    
        addSubviews()
//        scrollView.isScrollEnabled = true
        configureNavigationBar()
        addButtonActions()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureLayouts()
    }
    
    // MARK: - Methods
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(photoLabel)
        scrollView.addSubview(pollsLabel)
        scrollView.addSubview(roomsLabel)
        
        scrollView.addSubview(titleTextView)
        scrollView.addSubview(firstPollTextView)
        scrollView.addSubview(secondPollTextView)
        scrollView.addSubview(roomsTextView)
        
        scrollView.addSubview(videoButton)
        
        scrollView.addSubview(titleCountLabel)
        scrollView.addSubview(firstPollCountLabel)
        scrollView.addSubview(secondPollCountLabel)
    }
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Post",
            style: .done,
            target: self,
            action: #selector(didTapPost)
        )
    }

    private func configureLayouts() {
        scrollView.frame = view.bounds

        let padding: CGFloat = 16
        titleLabel.sizeToFit()
        titleLabel.frame = CGRect(
            x: padding,
            y: padding*2,
            width: titleLabel.width,
            height: titleLabel.height
        )
        
        NSLayoutConstraint.activate([
            titleTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding - 10),
            titleTextView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -4.6),
            titleTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ])
        
        titleCountLabel.sizeToFit()
        titleCountLabel.frame = CGRect(
            x: view.width-padding-titleCountLabel.width,
            y: titleTextView.bottom,
            width: titleCountLabel.width,
            height: titleCountLabel.height
        )
        
        photoLabel.sizeToFit()
        photoLabel.frame = CGRect(
            x: padding,
            y: titleCountLabel.bottom+24,
            width: photoLabel.width,
            height: photoLabel.height
        )
        
        videoButton.sizeToFit()
        videoButton.frame = CGRect(
            x: (view.width-padding)/2 - videoButton.width,
            y: photoLabel.bottom+padding,
            width: videoButton.width,
            height: videoButton.height
        )
        
        pollsLabel.sizeToFit()
        pollsLabel.frame = CGRect(
            x: padding,
            y: videoButton.bottom+24,
            width: 50,
            height: 20
        )

        firstPollTextView.frame = CGRect(
            x: padding,
            y: pollsLabel.bottom+padding,
            width: view.width-padding*2,
            height: 76
        )
        firstPollTextView.centerVerticalText()
        firstPollTextView.layer.cornerRadius = 38
        
        firstPollCountLabel.sizeToFit()
        firstPollCountLabel.frame = CGRect(
            x: view.width-padding-firstPollCountLabel.width,
            y: firstPollTextView.bottom+8,
            width: firstPollCountLabel.width,
            height: firstPollCountLabel.height
        )
        
        secondPollTextView.frame = CGRect(
            x: padding,
            y: firstPollCountLabel.bottom+8,
            width: view.width-padding*2,
            height: 76
        )
        secondPollTextView.centerVerticalText()
        secondPollTextView.layer.cornerRadius = 38
        
        secondPollCountLabel.sizeToFit()
        secondPollCountLabel.frame = CGRect(
            x: view.width-padding-secondPollCountLabel.width,
            y: secondPollTextView.bottom+8,
            width: secondPollCountLabel.width,
            height: secondPollCountLabel.height
        )
        
        roomsLabel.sizeToFit()
        roomsLabel.frame = CGRect(
            x: padding,
            y: secondPollCountLabel.bottom+24,
            width: roomsLabel.width,
            height: roomsLabel.height
        )
        
        NSLayoutConstraint.activate([
            roomsTextView.topAnchor.constraint(equalTo: roomsLabel.bottomAnchor, constant: padding - 10),
            roomsTextView.leadingAnchor.constraint(equalTo: roomsLabel.leadingAnchor, constant: -4.6),
            roomsTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
        ])
    
        scrollView.contentSize = CGSize(width: scrollView.width, height: scrollView.height + roomsTextView.height)

    }
    
    private func addButtonActions() {
        videoButton.addTarget(
            self,
            action: #selector(didTapSingle),
            for: .touchUpInside
        )

    }
    
    // MARK: - Objc

    @objc private func didTapPost() {
        
    }
    
    @objc private func didTapSingle() {
        let vc = SelectPictureViewController()
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true, completion: nil)
    }
    
    


}

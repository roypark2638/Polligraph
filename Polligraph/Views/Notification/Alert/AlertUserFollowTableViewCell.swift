//
//  AlertUserFollowTableViewCell.swift
//  Polligraph
//
//  Created by Roy Park on 4/8/21.
//

import UIKit

protocol AlertUserFollowCollectionViewCellDelegate: AnyObject {
    func alertUserFollowCollectionViewCell(_ cell: AlertUserFollowTableViewCell)
}

class AlertUserFollowTableViewCell: UITableViewCell {
    static let identifier = "AlertUserFollowTableViewCell"
    
    weak var delegate: AlertUserFollowCollectionViewCellDelegate?
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    public let alertLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Roboto-Regular", size: 16)
        label.textAlignment = .left
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let followButton: UIButton = {
        let button = UIButton()
        button.setTitle("Follow", for: .normal)
        button.backgroundColor = .label
        button.setTitleColor(.systemBackground, for: .normal)
        button.layer.cornerRadius = 14
        button.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 14)
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .secondaryLabel
        label.font = UIFont(name: "Roboto-Regular", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    var postID: String?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        addSubviews()
        configureLayouts()

        configureButtons()
    }

    
    required init?(coder: NSCoder) {
        fatalError()
    }

    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        alertLabel.text = nil
        dateLabel.text = nil
    }
    
    private func addSubviews() {
        addSubview(profileImageView)
        addSubview(alertLabel)
        addSubview(followButton)
//        addSubview(dateLabel)
    }
    
    private func configureLayouts() {
        NSLayoutConstraint.activate([
            profileImageView.heightAnchor.constraint(equalToConstant: 40),
            profileImageView.widthAnchor.constraint(equalToConstant: 40),
            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            profileImageView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -10)
        ])

        NSLayoutConstraint.activate([
            followButton.heightAnchor.constraint(equalToConstant: 28),
            followButton.widthAnchor.constraint(equalToConstant: 76),
            followButton.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            followButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            alertLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            alertLabel.trailingAnchor.constraint(equalTo: followButton.leadingAnchor, constant: -16),
            alertLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            alertLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        
        
//        let imageSize = CGFloat(40)
        
//        profileImageView.frame = CGRect(
//            x: 16,
//            y: 10,
//            width: imageSize,
//            height: imageSize
//        )
//
//        alertMessage.sizeToFit()
//        alertMessage.frame = CGRect(
//            x: profileImageView.right + 16,
//            y: profileImageView.top,
//            width: contentView.width-48-imageSize-76,
//            height: alertMessage.height
//        )
//
//        followButton.frame = CGRect(
//            x: alertMessage.right,
//            y: 16,
//            width: 76,
//            height: 28
//        )
                
    }
    
    private func configureButtons() {
        followButton.addTarget(self, action: #selector(didTapFollow), for: .touchUpInside)
    }
    
    func configure(with viewModel: FollowAlertCellViewModel) {       
        profileImageView.image = UIImage(named: "Profile Image2")
        alertLabel.text = "\(viewModel.username) started following you. asdfkalsjf awefj lds flaewj foawje fdaksdjkfl asdj f\n asdf ajewfajlsdjfadf \nasdf awefjasdfasdf \nawef asdf asef \n"
        dateLabel.text = .date(with: viewModel.date)
    }
    
    @objc private func didTapFollow() {
        delegate?.alertUserFollowCollectionViewCell(self)
    }
}

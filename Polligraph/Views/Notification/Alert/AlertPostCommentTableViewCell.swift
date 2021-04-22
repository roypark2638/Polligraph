//
//  AlertPostCommentTableViewCell.swift
//  Polligraph
//
//  Created by Roy Park on 4/8/21.
//

import UIKit

class AlertPostCommentTableViewCell: UITableViewCell {
    static let identifier = "AlertPostCommentCollectionViewCell"
    
    // MARK: - Subviews
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let alertLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Roboto-Regular", size: 16)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Regular", size: 16)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        contentView.clipsToBounds = true
        addSubviews()
        configureLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Lifecycle
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        alertLabel.text = nil
        dateLabel.text = nil
    }
    
    // MARK: - Methods
    
    private func configureLayouts() {
        NSLayoutConstraint.activate([
            profileImageView.heightAnchor.constraint(equalToConstant: 40),
            profileImageView.widthAnchor.constraint(equalToConstant: 40),
            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            profileImageView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            alertLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            alertLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            alertLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            alertLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
//        let imageSize = CGFloat(40)
//
//        profileImageView.layer.cornerRadius = imageSize/2
//        profileImageView.frame = CGRect(
//            x: 16,
//            y: 10,
//            width: imageSize,
//            height: imageSize
//        ).integral
//
//        alertLabel.sizeToFit()
//        alertLabel.frame = CGRect(
//            x: profileImageView.right + 16,
//            y: 10,
//            width: contentView.width - 32 - profileImageView.right,
//            height: alertLabel.height
//        ).integral
//
//        dateLabel.sizeToFit()
//        dateLabel.frame = CGRect(
//            x: alertLabel.right + 10,
//            y: alertLabel.bottom,
//            width: dateLabel.width,
//            height: dateLabel.height
//        ).integral
        
        
    }
    
    private func addSubviews() {
        addSubview(dateLabel)
        addSubview(alertLabel)
        addSubview(profileImageView)
    }

    func configure(with viewModel: CommentAlertCellViewModel) {
        profileImageView.image = UIImage(named: "Edit Profile Image")
        alertLabel.text = "\(viewModel.username) commented on your post."
    }
}

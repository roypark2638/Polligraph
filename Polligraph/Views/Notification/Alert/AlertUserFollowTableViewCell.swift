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
        return imageView
    }()
    
    private let alertMessage: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Roboto-Regular", size: 16)
        label.textColor = .label
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
        return button
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .secondaryLabel
        label.font = UIFont(name: "Roboto-Regular", size: 16)
        return label
    }()
    

    var postID: String?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        addSubviews()
        configureButtons()
    }
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        contentView.clipsToBounds = true
//
//        addSubviews()
//        configureButtons()
//    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureLayouts()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        alertMessage.text = nil
        dateLabel.text = nil
    }
    
    private func addSubviews() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(alertMessage)
        contentView.addSubview(followButton)
        contentView.addSubview(dateLabel)
    }
    
    private func configureLayouts() {
        let imageSize = CGFloat(40)
        
        profileImageView.frame = CGRect(
            x: 16,
            y: 10,
            width: imageSize,
            height: imageSize
        )
        
        alertMessage.sizeToFit()
        alertMessage.frame = CGRect(
            x: profileImageView.right + 16,
            y: profileImageView.top,
            width: contentView.width-48-imageSize-76,
            height: alertMessage.height
        )
        
        followButton.frame = CGRect(
            x: alertMessage.right,
            y: 16,
            width: 76,
            height: 28
        )
                
    }
    
    private func configureButtons() {
        followButton.addTarget(self, action: #selector(didTapFollow), for: .touchUpInside)
    }
    
    func configure(with viewModel: FollowAlertCellViewModel) {       
        profileImageView.image = UIImage(named: "Profile Image2")
        alertMessage.text = "\(viewModel.username) started following you."
        dateLabel.text = .date(with: viewModel.date)
    }
    
    @objc private func didTapFollow() {
        delegate?.alertUserFollowCollectionViewCell(self)
    }
}

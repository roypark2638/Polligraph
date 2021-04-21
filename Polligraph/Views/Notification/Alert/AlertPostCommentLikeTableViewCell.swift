//
//  AlertPostCommentLikeCollectionViewCell.swift
//  Polligraph
//
//  Created by Roy Park on 4/8/21.
//

import UIKit

class AlertPostCommentLikeTableViewCell: UITableViewCell {
    static let identifier = "AlertPostCommentLikeCollectionViewCell"

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
    }
    
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
            width: contentView.width-profileImageView.right-32,
            height: alertMessage.height
        )
        
    }
    
    
    func configure(with viewModel: LikeCommentAlertCellViewModel) {
        profileImageView.image = UIImage(named: "Profile Image")
        alertMessage.text = "\(viewModel.username) liked your comment on (postname)"
    }
    
}

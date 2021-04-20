//
//  AlertPostCommentTableViewCell.swift
//  Polligraph
//
//  Created by Roy Park on 4/8/21.
//

import UIKit

class AlertPostCommentTableViewCell: UITableViewCell {
    static let identifier = "AlertPostCommentCollectionViewCell"
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let alertLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Roboto-Regular", size: 16)
        label.textColor = .label
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont(name: "Roboto-Regular", size: 16)
        label.textColor = .secondaryLabel
        return label
    }()
    
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
        alertLabel.text = nil
        dateLabel.text = nil
    }
    
    func configure(with viewModel: Alert) {
        profileImageView.image = UIImage(named: "Profile Image")
        alertLabel.text = viewModel.text        
    }
    
    private func configureLayouts() {
        let imageSize = CGFloat(40)
                        
        profileImageView.layer.cornerRadius = imageSize/2
        profileImageView.frame = CGRect(
            x: 16,
            y: 10,
            width: imageSize,
            height: imageSize
        ).integral
        
        alertLabel.sizeToFit()
        alertLabel.frame = CGRect(
            x: profileImageView.right + 16,
            y: 10,
            width: contentView.width - 32 - profileImageView.right,
            height: alertLabel.height
        ).integral
        
//        dateLabel.sizeToFit()
//        dateLabel.frame = CGRect(
//            x: alertLabel.right + 10,
//            y: alertLabel.bottom,
//            width: dateLabel.width,
//            height: dateLabel.height
//        ).integral
        
        
    }
    
    private func addSubviews() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(alertLabel)
        contentView.addSubview(profileImageView)
    }

}

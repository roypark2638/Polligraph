//
//  AlertPostCommentReplyTableViewCell.swift
//  Polligraph
//
//  Created by Roy Park on 4/21/21.
//

import UIKit

class AlertPostCommentReplyTableViewCell: UITableViewCell {

    static let identifier = "AlertPostCommentReplyTableViewCell"

    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
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
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        configureLayouts()
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
        addSubview(dateLabel)
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
            alertLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            alertLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            alertLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            alertLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    
    func configure(with viewModel: ReplyCommentAlertCellViewModel) {
        profileImageView.image = UIImage(named: "Profile Image")
        alertLabel.text = "\(viewModel.username) replied to your comment on (postname)"
    }
}

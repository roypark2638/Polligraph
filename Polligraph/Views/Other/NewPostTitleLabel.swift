//
//  NewPostTitleLabel.swift
//  Polligraph
//
//  Created by Roy Park on 5/5/21.
//

import UIKit

class NewPostTitleLabel: UILabel {
    
    private let title: String

    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        configureLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureLabel() {
        text = title
        font = UIFont(name: "Roboto-Bold", size: 16)
        textAlignment = .left
        numberOfLines = 1
    }
}

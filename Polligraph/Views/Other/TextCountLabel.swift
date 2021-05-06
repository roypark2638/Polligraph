//
//  TextCountLabel.swift
//  Polligraph
//
//  Created by Roy Park on 5/5/21.
//

import UIKit

class TextCountLabel: UILabel {
    
    var count: Int

    init(count: Int) {
        self.count = count
        super.init(frame: .zero)
        configureLabel()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureLabel() {
        textColor = .secondaryLabel
        font = UIFont(name: "Roboto-regular", size: 14)
        text = String(count)
    }
}

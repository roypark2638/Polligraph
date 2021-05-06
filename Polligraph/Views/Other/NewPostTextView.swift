//
//  NewPostTextView.swift
//  Polligraph
//
//  Created by Roy Park on 5/5/21.
//

import UIKit

class NewPostTextView: UITextView {

    enum NewPostTextViewType: String {
        case title
        case description
        case firstPoll
        case secondPoll
        case rooms
        
        var placeholder: String {
            switch self {
            case .title:
                return "Type your title"
            case .description:
                return "Type your description"
            case .firstPoll:
                return "Type your poll option"
            case .secondPoll:
                return "Type your poll option"
            case .rooms:
                return "Type your rooms"
            }
        }
    }
    
    let type: NewPostTextViewType
    
    init(type: NewPostTextViewType) {
        self.type = type
        super.init(frame: .zero, textContainer: nil)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureView() {
        textAlignment = .left
        font = UIFont(name: "Roboto-Regular", size: 16)
        isScrollEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
//        translatesAutoresizingMaskIntoConstraints = true
//        sizeToFit()
//        let attributes = [NSAttributedString.Key.font : UIFont(name: "Roboto-Bold", size: 16)]
//        let attributedString = NSMutableAttributedString(
//            string: text,
//            attributes: attributes as [NSAttributedString.Key : Any])
//        let textStyle = NSMutableParagraphStyle()
//        textStyle.lineSpacing = 3
//        attributedString.addAttribute(
//            NSAttributedString.Key.paragraphStyle,
//            value: textStyle,
//            range: NSMakeRange(0, attributedString.length))
//
//        attributedText = attributedString
        
        switch type {
        case .title:
            placeholder = NewPostTextViewType.title.placeholder
        case .description:
            placeholder = NewPostTextViewType.description.placeholder
            
        case .firstPoll:
//            placeholder = NewPostTextViewType.firstPoll.placeholder
            translatesAutoresizingMaskIntoConstraints = true
//            textAlignment = .center
            
            textAlignment = .center
            layer.masksToBounds = true
            textColor = UIColor(rgb: 0x5E5E5E)
            backgroundColor = UIColor(rgb: 0xFF777B)
        case .secondPoll:
//            placeholder = NewPostTextViewType.secondPoll.placeholder
            translatesAutoresizingMaskIntoConstraints = true
            textAlignment = .center
            layer.masksToBounds = true
            textColor = UIColor(rgb: 0x5E5E5E)
            backgroundColor = UIColor(rgb: 0x3DB9BA)
        case .rooms:
            placeholder = NewPostTextViewType.rooms.placeholder
            
        }
    }

}


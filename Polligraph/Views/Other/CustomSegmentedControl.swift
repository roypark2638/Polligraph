//
//  CustomSegmentedControl.swift
//  Polligraph
//
//  Created by Roy Park on 4/20/21.
//

import UIKit

class CustomSegmentedControl: UIView {
    
    convenience init(frame: CGRect, buttonTitles: [String]) {
        self.init(frame: frame)
        self.buttonTitles = buttonTitles
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        updateView()
    }
    
    func setButtonTitles(buttonTitles: [String]) {
        self.buttonTitles = buttonTitles
        updateView()
    }

    private var buttonTitles = [String]()
    private var buttons: [UIButton] = []
    private var selectorView = UIView()
    
    private let textColor: UIColor = .secondaryLabel
    private let selectorViewColor: UIColor = .label
    private let selectorTextColor: UIColor = .label
    
    private func configureStackView() {
        let stack = UIStackView(arrangedSubviews: buttons)
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stack.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    private func configureSelectorView() {
//        let selectorWidth = width/CGFloat(self.buttonTitles.count)
        buttons[0].titleLabel?.sizeToFit()
        let selectorWidth: CGFloat = buttons[0].titleLabel!.width
        
        selectorView.frame = CGRect(
            x: ((width/2)-selectorWidth)/2,
            y: self.height,
            width: selectorWidth,
            height: 2
        )
        
        selectorView.backgroundColor = selectorViewColor
        addSubview(selectorView)
    }
    
    private func createButton() {
        buttons = [UIButton]()
        buttons.removeAll()
        subviews.forEach({ $0.removeFromSuperview() })
        for buttonTitle in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 18)
            button.addTarget(
                self,
                action: #selector(CustomSegmentedControl.buttonAction(sender:)),
                for: .touchUpInside
            )
            button.setTitleColor(textColor, for: .normal)
            buttons.append(button)
        }
        buttons[0].setTitleColor(selectorTextColor, for: .normal)
    }
    
    private func updateView() {
        createButton()
        configureSelectorView()
        configureStackView()
    }
    
    @objc private func buttonAction(sender: UIButton) {
        for (buttonIndex, button) in buttons.enumerated() {
            button.setTitleColor(textColor, for: .normal)
            if button == sender {
                button.titleLabel?.sizeToFit()
                let selectorWidth: CGFloat = button.titleLabel!.width
                let selectorPosition = (((width/2)-selectorWidth)/2) + (width/2) * CGFloat(buttonIndex)
                UIView.animate(withDuration: 0.3) {
                    self.selectorView.frame.origin.x = selectorPosition
                }
                button.setTitleColor(selectorTextColor, for: .normal)
            }
        }
    }
}

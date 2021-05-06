//
//  Extensions.swift
//  Polligraph
//
//  Created by Roy Park on 3/6/21.
//

import UIKit

extension UIView {
    // computed property to simplify the code for setting constraints
    
    public var width: CGFloat {
        return frame.size.width
    }
    
    public var height: CGFloat {
        return frame.size.height
    }
    
    public var left: CGFloat{
        return frame.origin.x
    }
    
    public var right: CGFloat{
        return left + width
    }
    
    public var top: CGFloat {
        return frame.origin.y
    }
    
    public var bottom: CGFloat {
        return top + height
    }
    
}

extension UIViewController {
    // create the loading effect
    static func displayLoading(withView: UIView) -> UIView {
        
        let spinnerView = UIView.init(frame: withView.bounds)
        // we want this spinner background view to be invisible
        spinnerView.backgroundColor = UIColor.clear
        
        let activityIndicator = UIActivityIndicatorView.init(style: .medium)
        
        activityIndicator.startAnimating()
        activityIndicator.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(activityIndicator)
            withView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    
    // remove the loading effect
    static func removeLoading(spinner: UIView) {
        
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}


extension String {
    func safeDatabaseKey() -> String {
        return self.replacingOccurrences(of: ".", with: "-")
            .self.replacingOccurrences(of: "#", with: "-")
            .self.replacingOccurrences(of: "[", with: "-")
            .self.replacingOccurrences(of: "]", with: "-")
            .self.replacingOccurrences(of: "$", with: "-")
    }
}

extension NumberFormatter {
    public static let groupingFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.groupingSize = 3
        formatter.maximumFractionDigits = 1
        return formatter
    }()
}

extension Double {
    public var followersFormatted: String {
        if self >= 1_000, self < 1_000_000 {
            return NumberFormatter.groupingFormatter.string(
                from: NSNumber(value: self / 1_000))! + "k"
        }
        
        if self >= 1_000_000 {
            return NumberFormatter.groupingFormatter.string(
                from: NSNumber(value: self / 1_000_000))! + "m"
        }
        
        return NumberFormatter.groupingFormatter.string(from: NSNumber(value: self))!
    }
}

extension Int {
    public var followersFormatted: String {
        Double(self).followersFormatted
    }
}

extension DateFormatter {
    static let defaultFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.locale = .current
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
}

extension String {
    static func date(with date: Date) -> String {
        return DateFormatter.defaultFormatter.string(from: date)
    }
}

// Allow us to cleanly take dictionary to in from different object that conforms to the Codable.
extension Decodable {
    init?(with dictionary: [String: Any]) {
        // convert to the data
        guard let data = try? JSONSerialization.data(
                withJSONObject: dictionary,
                options: .prettyPrinted
        ) else {
            return nil
        }
        guard let result = try? JSONDecoder().decode(Self.self, from: data) else {
            return nil
        }
        
        self = result
    }
}

extension Encodable {
    // You can now map stuff from the database directly into model instead of doing an unnecessary step
    func asDictionary() -> [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        guard let json = try? JSONSerialization.jsonObject(
                with: data,
                options: .allowFragments
        ) as? [String: Any] else {
            return nil
        }
        return json

    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

/// Extend UITextView and implemented UITextViewDelegate to listen for changes
extension UITextView: UITextViewDelegate {
    
    /// Resize the placeholder when the UITextView bounds change
    override open var bounds: CGRect {
        didSet {
            self.resizePlaceholder()
        }
    }
    
    /// The UITextView placeholder text
    public var placeholder: String? {
        get {
            var placeholderText: String?
            
            if let placeholderLabel = self.viewWithTag(100) as? UILabel {
                placeholderText = placeholderLabel.text
            }
            
            return placeholderText
        }
        set {
            if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
                placeholderLabel.text = newValue
                placeholderLabel.sizeToFit()
            } else {
                self.addPlaceholder(newValue!)
            }
        }
    }
    
    /// When the UITextView did change, show or hide the label based on if the UITextView is empty or not
    ///
    /// - Parameter textView: The UITextView that got updated
    public func textViewDidChange(_ textView: UITextView) {
        if let placeholderLabel = self.viewWithTag(100) as? UILabel {
            placeholderLabel.isHidden = !self.text.isEmpty
        }
    }
    
    /// Resize the placeholder UILabel to make sure it's in the same position as the UITextView text
    private func resizePlaceholder() {
        if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
            let labelX: CGFloat = 3
            let labelY = (self.textContainerInset.top-2)
            let labelWidth = placeholderLabel.width
            let labelHeight = placeholderLabel.height
            
//            let labelX = self.textContainer.lineFragmentPadding
//            let labelY = self.textContainerInset.top - 2
//            let labelWidth = self.frame.width - (labelX * 2)
//            let labelHeight = placeholderLabel.frame.height
            
            placeholderLabel.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
        }
    }
    
    /// Adds a placeholder UILabel to this UITextView
    private func addPlaceholder(_ placeholderText: String) {
        let placeholderLabel = UILabel()
        
        placeholderLabel.text = placeholderText
        placeholderLabel.sizeToFit()
        
        placeholderLabel.font = self.font
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.tag = 100
        
        placeholderLabel.isHidden = !self.text.isEmpty
        
        self.addSubview(placeholderLabel)
        self.delegate = self
        self.resizePlaceholder()
    }
    
}


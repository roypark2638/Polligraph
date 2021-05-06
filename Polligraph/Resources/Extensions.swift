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

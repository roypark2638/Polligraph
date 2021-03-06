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


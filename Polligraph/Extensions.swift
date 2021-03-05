//
//  Extensions.swift
//  Polligraph
//
//  Created by Roy Park on 3/2/21.
//

import Foundation
import UIKit

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

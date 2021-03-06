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
    
    public var top: CGRect {
        return frame.origin.y
    }
    
    public var bottom: CGRect {
        return top + height
    }
    
}


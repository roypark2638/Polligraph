//
//  Helper.swift
//  Polligraph
//
//  Created by Roy Park on 3/2/21.
//

import Foundation
import UIKit

struct Helper {
    
    static func errorAlert(title: String, message: String) -> UIAlertController {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(okAction)
        return alert
    }
    
    
}

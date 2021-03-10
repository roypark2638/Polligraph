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
    
    static func isPasswordValid(password: String) -> Bool {
        /*
         ^                 - Start Anchor.
         (?=.*[a-z])       - Ensure string has one character.
         (?=.[$@$#!%?&])   - Ensure string has one special character.
         {8,}              - Ensure password length is 8.
         $                 - End Anchor.
         */
        let passwordTest = NSPredicate(
            format: "SELF MATCHES %@",
            "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}") // regular expression
        return passwordTest.evaluate(with: password)
    }
    
}

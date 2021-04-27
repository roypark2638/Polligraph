//
//  NewPostPages.swift
//  Polligraph
//
//  Created by Roy Park on 4/27/21.
//

import Foundation

enum NewPostPages: Int {
    case library
    case camera
    
    var identifier: String {
        switch self {
        case .library: return "Library"
        case .camera: return "Camera"
        }
    }
    
    static func pagesToShow() -> [NewPostPages] {
        return [.library, .camera]
    }
}

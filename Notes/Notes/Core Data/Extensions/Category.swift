//
//  Category.swift
//  Notes
//
//  Created by Marian Stanciulica on 18/09/2018.
//  Copyright © 2018 Marian Stanciulica. All rights reserved.
//

import UIKit

extension Category {
    
    var color: UIColor? {
        get {
            guard let hex = colorAsHex else { return nil }
            return UIColor(hex: hex)
        }
        set(newColor) {
            if let newColor = newColor {
                colorAsHex = newColor.toHex
            }
        }
    }
    
}

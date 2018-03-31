//
//  UIColor+Extenstions.swift
//  BreathingSquare
//
//  Created by Oleksii Huralnyk on 3/31/18.
//  Copyright © 2018 Oleksii Huralnyk. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init?(hexString: String) {
        // TODO: Add support of RGBA hex colors
        let escaped = hexString.replacingOccurrences(of: "#", with: "")
        guard escaped.count == 6 else { return nil }
        guard let hex = Int(escaped, radix: 16) else { return nil }
        
        let red = CGFloat(hex >> 16 & 0xFF) / 255
        let green = CGFloat(hex >> 8 & 0xFF) / 255
        let blue = CGFloat(hex & 0xFF) / 255
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
}

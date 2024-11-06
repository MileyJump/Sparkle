//
//  Color.swift
//  Sparkle
//
//  Created by 최민경 on 10/31/24.
//

import UIKit

extension UIColor {
    
    // Brand
    static let sparkleBrandOrangeColor = UIColor(hexCode: "FF6500")
    static let sparkleBrandErrorColor = UIColor(hexCode: "E9666B")
    static let sparkleBrandInactiveColor = UIColor(hexCode: "AAAAAA")
    static let sparkleBrandBlackColor = UIColor(hexCode: "000000")
    static let sparkleBrandGrayColor = UIColor(hexCode: "DDDDDD")
    static let sparkleBrandWhiteColor = UIColor(hexCode: "FFFFFF")
    
    // Text
    static let sparkleTextPrimaryColor = UIColor(hexCode: "1C1C1C")
    static let sparkleTextSecondaryColor = UIColor(hexCode: "606060")
    
    // Background
    static let sparkleBackgroundPrimaryColor = UIColor(hexCode: "F6F6F6")
    static let sparkleBackgroundSecondaryColor = UIColor(hexCode: "FFFFFF")
    
    // View
    static let sparkleViewSeperatorColor = UIColor(hexCode: "ECECEC")
    static let sparkleViewAlphaColor = UIColor(hexCode: "000000").withAlphaComponent(0.5)
}


extension UIColor {
    
    convenience init(hexCode: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hexCode.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}

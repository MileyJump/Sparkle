//
//  UIView +.swift
//  Sparkle
//
//  Created by 최민경 on 11/13/24.
//

import UIKit

extension UIView: ReusableProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}

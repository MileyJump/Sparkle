//
//  NewMessageButton.swift
//  Sparkle
//
//  Created by 최민경 on 11/5/24.
//

import UIKit

extension UIButton {
    
    func newMessageButton(title: String, image: UIImage?, titleImageSpacing: CGFloat = 8) {
        
        var config = UIButton.Configuration.plain() // 기본 구성 생성
        
        config.image = image
        config.imagePadding = titleImageSpacing
        
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 14)
        
        var attributes = AttributeContainer()
        attributes.font = UIFont.systemFont(ofSize: 13)
        
        config.attributedTitle = AttributedString(title, attributes: attributes)
        config.baseBackgroundColor = .black
        config.baseForegroundColor = .black
        
        self.configuration = config
        
        self.contentHorizontalAlignment = .left
    }
}

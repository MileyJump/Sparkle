//
//  ChannelsButton.swift
//  Sparkle
//
//  Created by 최민경 on 11/4/24.
//

import UIKit

final class ChannelsButton: UIButton {
    
    init(title: String, image: UIImage?, backgroundColor: UIColor, tintColor: UIColor, font: UIFont) {
        super.init(frame: .zero)
        
        var config = UIButton.Configuration.plain()
        config.image = image
        config.imagePadding = 8
        config.imagePlacement = .trailing
        config.baseBackgroundColor = backgroundColor
        config.baseForegroundColor = tintColor
        config.cornerStyle = .medium
        
    
        if let image = image {
            let resizedImage = image.withConfiguration(UIImage.SymbolConfiguration(pointSize: 13)) 
            config.image = resizedImage
        }
        
        var attributedTitle = AttributedString(title)
        attributedTitle.font = font
        attributedTitle.foregroundColor = tintColor
        config.attributedTitle = attributedTitle
        
        self.configuration = config
        
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



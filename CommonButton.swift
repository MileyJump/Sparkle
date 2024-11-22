//
//  CommonButton.swift
//  Sparkle
//
//  Created by 최민경 on 11/2/24.
//

import UIKit

final class CommonButton: UIButton {
    
    init(image: UIImage?, title: String, backgroundColor: UIColor, tintColor: UIColor, font: UIFont) {
        super.init(frame: .zero)
        
        var config = UIButton.Configuration.filled()
        config.image = image
        config.imagePadding = 8
        config.imagePlacement = .leading
        config.baseBackgroundColor = backgroundColor
        config.baseForegroundColor = tintColor
        config.cornerStyle = .medium
        
    
        if let image = image {
            let resizedImage = image.withConfiguration(UIImage.SymbolConfiguration(pointSize: 13)) // 원하는 크기로 설정
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


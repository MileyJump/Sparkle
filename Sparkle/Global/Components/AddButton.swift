//
//  AddButton.swift
//  Sparkle
//
//  Created by 최민경 on 12/16/24.
//

import UIKit

final class AddButton: UIButton {
    
    init(title: String,
         image: UIImage? = nil,
         backgroundColor: UIColor? = .clear,
         tintColor: UIColor? = .sparkleTextSecondaryColor,
         font: UIFont? = UIFont.systemFont(ofSize: 13),
         cornerRadius: CGFloat = 8) {
        
        super.init(frame: .zero)
        configureButton(title: title, image: image, backgroundColor: backgroundColor, tintColor: tintColor, font: font, cornerRadius: cornerRadius)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Button Configuration
    private func configureButton(title: String, image: UIImage?, backgroundColor: UIColor?, tintColor: UIColor?, font: UIFont?, cornerRadius: CGFloat) {
        
        var configuration = UIButton.Configuration.plain()
        configuration.title = title
        configuration.image = image
        configuration.imagePadding = 8
        configuration.baseBackgroundColor = backgroundColor
        configuration.baseForegroundColor = tintColor
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = font
            return outgoing
        }
        
        self.configuration = configuration
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }
}

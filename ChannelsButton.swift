//
//  ChannelsButton.swift
//  Sparkle
//
//  Created by 최민경 on 11/4/24.
//

import UIKit

import SnapKit

final class ChannelsButton: UIButton {
    
    init(title: String, image: UIImage?, backgroundColor: UIColor, tintColor: UIColor, font: UIFont) {
        super.init(frame: .zero)
        
        self.backgroundColor = backgroundColor
        self.tintColor = tintColor
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = font
        titleLabel.textColor = tintColor
        self.addSubview(titleLabel)
        
        let imageView = UIImageView()
        if let image = image {
            imageView.image = image.withConfiguration(UIImage.SymbolConfiguration(pointSize: 13))
        }
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
        
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

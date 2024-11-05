//
//  NewMessageButton.swift
//  Sparkle
//
//  Created by 최민경 on 11/5/24.
//

import UIKit

import UIKit

extension UIButton {
    
    func NewMessageButton(title: String, image: UIImage?) {
        // 이미지와 타이틀 설정
        setTitle(title, for: .normal)
        setImage(image, for: .normal)
        
        // 이미지와 타이틀의 레이아웃 조정
        semanticContentAttribute = .forceLeftToRight
        contentHorizontalAlignment = .left
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 8) // 이미지와 타이틀 간격 조정
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: -8)
        
        // 필요한 경우 추가 스타일 설정
        titleLabel?.font = UIFont.systemFont(ofSize: 16)
        setTitleColor(.black, for: .normal)
    }
}

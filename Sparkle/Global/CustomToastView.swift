//
//  CustomToastView.swift
//  Sparkle
//
//  Created by 최민경 on 11/1/24.
//

import UIKit

import Then
import SnapKit

final class CustomToastView: UIView {
    
    init(message: String, icon: String) {
        super.init(frame: .zero)
        setupToastView(toastMessage: message, toastIcon: icon)
        
        layer.shadowOpacity = 0.2        // 그림자 투명도 (0~1)
        layer.shadowOffset = CGSize(width: 2, height: 2) // 그림자 위치 조정
        layer.shadowRadius = 3.0          // 그림자 퍼짐 정도
        layer.masksToBounds = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupToastView(toastMessage: String, toastIcon: String) {
        
        backgroundColor = UIColor.sparkleBackgroundSecondaryColor
        layer.cornerRadius = 3
        clipsToBounds = true
        
        let lineView = UIView().then {
            $0.backgroundColor = UIColor.sparkleBrandOrangeColor
        }
        
        let toastIcon = UIImageView().then {
            $0.image = UIImage(systemName: toastIcon)
        }
        
        let messageLabel = UILabel().then {
            $0.text = toastMessage
            $0.textColor = UIColor.sparkleTextPrimaryColor
            $0.font = UIFont.systemFont(ofSize: 14)
            $0.numberOfLines = 0
            $0.textAlignment = .left
        }
        
        addSubview(lineView)
        addSubview(toastIcon)
        addSubview(messageLabel)
        
        lineView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalTo(5)
        }
        
        toastIcon.snp.makeConstraints { make in
            make.leading.equalTo(lineView.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(toastIcon.snp.trailing).offset(10)
            make.trailing.equalToSuperview()
        }
    }
    
    func showToast(duration: TimeInterval = 2.0) {
        
        // Toast 애니메이션 (페이드인 -> 페이드아웃)
        self.alpha = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 1
        }) { _ in
            UIView.animate(withDuration: 0.3, delay: duration, options: .curveEaseOut, animations: {
                self.alpha = 0
            }) { _ in
                self.removeFromSuperview()
            }
        }
    }
}



//
//  OnboardingView.swift
//  Sparkle
//
//  Created by 최민경 on 10/31/24.
//

import UIKit

import Then
import SnapKit

final class OnboardingView: BaseView {
    
    private let serviceName = UILabel().then {
        $0.text = "Sparkle"
        $0.textAlignment = .center
        
    }
    
    private let onboardingLabel = UILabel().then {
        $0.text = "새싹톡을 사용하면 어디서나 팀을 모을 수 있습니다."
    }
    
    private let onboardingImage = UIImageView().then {
        $0.image = UIImage(named: "온보딩이미지")
    }
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func setupSubviews() {
        addSubview(onboardingLabel)
        addSubview(onboardingImage)
        
    }
    
    override func setupLayout() {
        
        serviceName.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(100)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
        }
        
        
        
    }
    
}
    

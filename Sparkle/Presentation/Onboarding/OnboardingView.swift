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
        $0.font = UIFont.boldSystemFont(ofSize: 40)
        $0.textColor = UIColor.sparkleBrandOrangeColor
    }
    
    private let onboardingImage = UIImageView().then {
        $0.image = UIImage(named: "온보딩")
    }
    
    private let onboardingLabel = UILabel().then {
        $0.text = "대화의 즐거움을 \n 반짝이게 만들어보세요!"
        $0.font = UIFont.boldSystemFont(ofSize: 22)
        $0.textColor = UIColor.sparkleTextPrimaryColor
        $0.textAlignment = .center
        $0.numberOfLines = 2
    }
    
    private let startButton = UIButton().then {
        $0.setTitle("시작하기", for: .normal)
        $0.backgroundColor = UIColor.sparkleBrandOrangeColor
        $0.setTitleColor(UIColor.sparkleBrandWhiteColor, for: .normal)
        $0.layer.cornerRadius = 8
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func setupSubviews() {
        self.addSubview(serviceName)
        self.addSubview(onboardingImage)
        self.addSubview(onboardingLabel)
        self.addSubview(startButton)
    }
    
    override func setupLayout() {
        
        serviceName.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(60)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
        }
        
        onboardingImage.snp.makeConstraints { make in
            make.top.equalTo(serviceName.snp.bottom).offset(40)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(40)
            make.height.equalTo(onboardingImage.snp.width).multipliedBy(1.2)
        }
        
        onboardingLabel.snp.makeConstraints { make in
            make.top.equalTo(onboardingImage.snp.bottom).offset(40)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
        
        startButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(24)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
            make.height.equalTo(44)
        }
    }
}
    

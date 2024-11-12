//
//  CreateChannelView.swift
//  Sparkle
//
//  Created by 최민경 on 11/12/24.
//

import UIKit

final class CreateChannelView: BaseView {
    
    private let channelNameLabel = UILabel().then {
        $0.text = "채널 이름"
        $0.textColor = UIColor.sparkleTextPrimaryColor
        $0.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    private let channelNameBackgroundView = UIView().then {
        $0.backgroundColor = UIColor.sparkleBrandWhiteColor
        $0.layer.cornerRadius = 8
    }
    
    private let channelNameTextField = UITextField().then {
        $0.placeholder = "채널 이름을 입력해주세요 (필수)"
        $0.font = UIFont.systemFont(ofSize: 13)
        $0.textColor = UIColor.sparkleTextPrimaryColor
        $0.backgroundColor = UIColor.sparkleBrandWhiteColor
    }
    
    private let channelExplanationLabel = UILabel().then {
        $0.text = "채널 설명"
        $0.textColor = UIColor.sparkleTextPrimaryColor
        $0.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    private let channelExplanationBackgroundView = UIView().then {
        $0.backgroundColor = UIColor.sparkleBrandWhiteColor
        $0.layer.cornerRadius = 8
    }
    
    private let channelExplanationTextField = UITextField().then {
        $0.placeholder = "채널을 설명하세요. (옵션)"
        $0.font = UIFont.systemFont(ofSize: 13)
        $0.textColor = UIColor.sparkleTextPrimaryColor
        $0.backgroundColor = UIColor.sparkleBrandWhiteColor
    }
    
    let confirmButton = CommonButton(image: nil, title: "완료", backgroundColor: UIColor.sparkleBrandInactiveColor, tintColor: UIColor.sparkleBrandWhiteColor, font: UIFont.boldSystemFont(ofSize: 14))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    
    override func setupSubviews() {
        
        
        
        addSubview(channelNameLabel)
        addSubview(channelNameBackgroundView)
        addSubview(channelNameTextField)
        addSubview(channelExplanationLabel)
        addSubview(channelExplanationBackgroundView)
        addSubview(channelExplanationTextField)
        addSubview(confirmButton)
    }
    
    override func setupLayout() {
      
        
        channelNameLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
            make.height.equalTo(24)
        }
        
        channelNameBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(channelNameLabel.snp.bottom).offset(8)
            make.height.equalTo(44)
            make.horizontalEdges.equalTo(channelNameLabel)
        }
        
        channelNameTextField.snp.makeConstraints { make in
            make.verticalEdges.equalTo(channelNameBackgroundView)
            make.horizontalEdges.equalTo(channelNameBackgroundView).inset(12)
        }
        
        channelExplanationLabel.snp.makeConstraints { make in
            make.top.equalTo(channelNameTextField.snp.bottom).offset(24)
            make.height.horizontalEdges.equalTo(channelNameLabel)
        }
        
        channelExplanationBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(channelExplanationLabel.snp.bottom).offset(8)
            make.height.horizontalEdges.equalTo(channelNameBackgroundView)
        }
        
        channelExplanationTextField.snp.makeConstraints { make in
            make.verticalEdges.equalTo(channelExplanationBackgroundView)
            make.horizontalEdges.equalTo(channelExplanationBackgroundView).inset(12)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.bottom.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
        }
    }
}


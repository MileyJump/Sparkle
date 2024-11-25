//
//  EmailLoginView.swift
//  Sparkle
//
//  Created by 최민경 on 11/24/24.
//

import UIKit

import Then
import SnapKit


final class EmailLoginView: BaseView {
    
    private let emailLabel = UILabel().then {
        $0.text = "이메일"
        $0.textColor = UIColor.sparkleTextPrimaryColor
        $0.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    private let emailBackgroundView = UIView().then {
        $0.backgroundColor = UIColor.sparkleBrandWhiteColor
        $0.layer.cornerRadius = 8
    }
    
    let emailTextField = UITextField().then {
        $0.placeholder = "이메일을 입력하세요."
        $0.font = UIFont.systemFont(ofSize: 13)
        $0.textColor = UIColor.sparkleTextPrimaryColor
        $0.backgroundColor = UIColor.sparkleBrandWhiteColor
        $0.text = "1234@1234.com"
    }
    
    private let passwordLabel = UILabel().then {
        $0.text = "비밀번호"
        $0.textColor = UIColor.sparkleTextPrimaryColor
        $0.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    private let passwordBackgroundView = UIView().then {
        $0.backgroundColor = UIColor.sparkleBrandWhiteColor
        $0.layer.cornerRadius = 8
    }
    
    let passwordTextField = UITextField().then {
        $0.placeholder = "비밀번호를 입력하세요."
        $0.font = UIFont.systemFont(ofSize: 13)
        $0.textColor = UIColor.sparkleTextPrimaryColor
        $0.backgroundColor = UIColor.sparkleBrandWhiteColor
        $0.text = "Mk1234@@"
    }
    
    let confirmButton = CommonButton(image: nil, title: "완료", backgroundColor: UIColor.sparkleBrandInactiveColor, tintColor: UIColor.sparkleBrandWhiteColor, font: UIFont.boldSystemFont(ofSize: 14))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func setupSubviews() {
    
        addSubview(emailLabel)
        addSubview(emailBackgroundView)
        addSubview(emailTextField)
        addSubview(passwordLabel)
        addSubview(passwordBackgroundView)
        addSubview(passwordTextField)
        addSubview(confirmButton)
    }
    
    override func setupLayout() {
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(16)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
            make.height.equalTo(24)
        }
        
        emailBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(8)
            make.height.equalTo(44)
            make.horizontalEdges.equalTo(emailLabel)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.verticalEdges.equalTo(emailBackgroundView)
            make.horizontalEdges.equalTo(emailBackgroundView).inset(12)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(24)
            make.height.horizontalEdges.equalTo(emailLabel)
        }
        
        passwordBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(8)
            make.height.horizontalEdges.equalTo(emailBackgroundView)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.verticalEdges.equalTo(passwordBackgroundView)
            make.horizontalEdges.equalTo(passwordBackgroundView).inset(12)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.bottom.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
        }
    }
}

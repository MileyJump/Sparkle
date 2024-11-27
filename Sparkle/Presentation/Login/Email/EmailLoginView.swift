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
    
    let emailValidationLabel = UILabel().then {
        $0.textColor = .sparkleBrandOrangeColor
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.text = "이메일 형식이 올바르지 않습니다."
        $0.textAlignment = .left
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
    
    let passwordValidationLabel = UILabel().then {
        $0.textColor = .sparkleBrandOrangeColor
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textAlignment = .left
        $0.text = "비밀번호는 최소 8자 이상, 하나 이상의 대소문자/숫자/특수 문자를 설정해주세요."
    }
    
    let confirmButton = CommonButton(image: nil, title: "완료", backgroundColor: UIColor.sparkleBrandInactiveColor, tintColor: UIColor.sparkleBrandWhiteColor, font: UIFont.boldSystemFont(ofSize: 14))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func setupSubviews() {
    
        addSubview(emailLabel)
        addSubview(emailBackgroundView)
        addSubview(emailTextField)
        addSubview(emailValidationLabel)
        
        addSubview(passwordLabel)
        addSubview(passwordBackgroundView)
        addSubview(passwordTextField)
        addSubview(passwordValidationLabel)
        
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
        
        emailValidationLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(emailBackgroundView)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(emailValidationLabel.snp.bottom).offset(24)
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
        
        passwordValidationLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(passwordBackgroundView)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.bottom.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
        }
    }
}

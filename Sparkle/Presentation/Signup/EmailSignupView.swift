//
//  EmailSignupView.swift
//  Sparkle
//
//  Created by 최민경 on 11/24/24.
//

import Foundation

import UIKit
import SnapKit
import Then

final class EmailSignupView: BaseView {
    
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
    }
    
    let emailDuplicateCheckButton = UIButton().then {
        $0.setTitle("중복확인", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        $0.backgroundColor = UIColor.sparkleBrandOrangeColor
        $0.layer.cornerRadius = 10
    }
    
    let emailDuplicateCheckLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 13)
        $0.textColor = .sparkleBrandWhiteColor
        $0.textAlignment = .center
    }
    
    private let nicknameLabel = UILabel().then {
        $0.text = "닉네임"
        $0.textColor = UIColor.sparkleTextPrimaryColor
        $0.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    private let nicknameBackgroundView = UIView().then {
        $0.backgroundColor = UIColor.sparkleBrandWhiteColor
        $0.layer.cornerRadius = 8
    }
    
    let nicknameTextField = UITextField().then {
        $0.placeholder = "닉네임을 입력하세요."
        $0.font = UIFont.systemFont(ofSize: 13)
        $0.textColor = UIColor.sparkleTextPrimaryColor
        $0.backgroundColor = UIColor.sparkleBrandWhiteColor
    }
    
    private let phoneNumberLabel = UILabel().then {
        $0.text = "비밀번호"
        $0.textColor = UIColor.sparkleTextPrimaryColor
        $0.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    private let phoneNumberBackgroundView = UIView().then {
        $0.backgroundColor = UIColor.sparkleBrandWhiteColor
        $0.layer.cornerRadius = 8
    }
    
    let phoneNumberTextField = UITextField().then {
        $0.placeholder = "비밀번호를 입력하세요."
        $0.font = UIFont.systemFont(ofSize: 13)
        $0.textColor = UIColor.sparkleTextPrimaryColor
        $0.backgroundColor = UIColor.sparkleBrandWhiteColor
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
    }
    
    private let passwordCheckLabel = UILabel().then {
        $0.text = "비밀번호"
        $0.textColor = UIColor.sparkleTextPrimaryColor
        $0.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    private let passwordCheckBackgroundView = UIView().then {
        $0.backgroundColor = UIColor.sparkleBrandWhiteColor
        $0.layer.cornerRadius = 8
    }
    
    let passwordCheckTextField = UITextField().then {
        $0.placeholder = "비밀번호를 입력하세요."
        $0.font = UIFont.systemFont(ofSize: 13)
        $0.textColor = UIColor.sparkleTextPrimaryColor
        $0.backgroundColor = UIColor.sparkleBrandWhiteColor
    }
    
    let confirmButton = CommonButton(image: nil, title: "완료", backgroundColor: UIColor.sparkleBrandInactiveColor, tintColor: UIColor.sparkleBrandWhiteColor, font: UIFont.boldSystemFont(ofSize: 14))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func setupSubviews() {
    
        addSubview(emailLabel)
        addSubview(emailBackgroundView)
        addSubview(emailTextField)
        
        addSubview(emailDuplicateCheckLabel)
        addSubview(emailDuplicateCheckButton)
        
        addSubview(nicknameLabel)
        addSubview(nicknameBackgroundView)
        addSubview(nicknameTextField)
        
        addSubview(phoneNumberLabel)
        addSubview(phoneNumberBackgroundView)
        addSubview(phoneNumberTextField)
        
        addSubview(passwordLabel)
        addSubview(passwordBackgroundView)
        addSubview(passwordTextField)
        
        addSubview(passwordCheckLabel)
        addSubview(passwordCheckBackgroundView)
        addSubview(passwordCheckTextField)
        addSubview(confirmButton)
    }
    
    override func setupLayout() {
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(16)
            make.leading.equalTo(safeAreaLayoutGuide).inset(24)
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
        
        emailDuplicateCheckButton.snp.makeConstraints { make in
            make.leading.equalTo(emailTextField.snp.trailing).offset(12)
            make.trailing.equalTo(24)
            make.width.equalTo(100)
            make.height.equalTo(44)
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

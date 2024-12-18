//
//  LoginView.swift
//  Sparkle
//
//  Created by 최민경 on 12/18/24.
//

import UIKit

import Then
import SnapKit

final class LoginView: BaseView {
    
    let appleLoginButton = CommonButton(image: UIImage(named: "Apple") , title: "Apple로 계속하기", backgroundColor: .sparkleBrandBlackColor, tintColor: .sparkleBrandWhiteColor, font: UIFont.boldSystemFont(ofSize: 15))
    
    let kakaoLoginButton = CommonButton(image: UIImage(named: "Kakao") , title: "카카오로 계속하기", backgroundColor: .sparkleKakaOColor, tintColor: .sparkleBrandBlackColor, font: UIFont.boldSystemFont(ofSize: 15))
    
    let emailLoginButton = CommonButton(image: UIImage(named: "EmailIcon") , title: "이메일로 계속하기", backgroundColor: .sparkleBrandOrangeColor, tintColor: .sparkleBrandWhiteColor, font: UIFont.boldSystemFont(ofSize: 15))
    
    let signUpButton = UIButton().then {
        $0.setTitle("또는 새롭게 회원가입 하기", for: .normal)
        $0.setTitleColor(.sparkleBrandOrangeColor, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func setupSubviews() {
        addSubview(appleLoginButton)
        addSubview(kakaoLoginButton)
        addSubview(emailLoginButton)
        addSubview(signUpButton)
    }
    
    override func setupLayout() {
        appleLoginButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(42)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(35)
            make.height.equalTo(44)
        }
        
        kakaoLoginButton.snp.makeConstraints { make in
            make.top.equalTo(appleLoginButton.snp.bottom).offset(16)
            make.height.horizontalEdges.equalTo(appleLoginButton)
        }
        
        emailLoginButton.snp.makeConstraints { make in
            make.top.equalTo(kakaoLoginButton.snp.bottom).offset(16)
            make.height.horizontalEdges.equalTo(appleLoginButton)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(emailLoginButton.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(appleLoginButton)
            make.height.equalTo(20)
        }
    }
}

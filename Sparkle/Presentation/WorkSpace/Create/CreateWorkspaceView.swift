//
//  CreateWorkspaceView.swift
//  Sparkle
//
//  Created by 최민경 on 11/8/24.
//

import UIKit

import Then
import SnapKit

final class CreateWorkspaceView: BaseView {
    
    private let profileImageView = UIImageView().then {
        $0.image = UIImage(named: "workspaceBubble")
        $0.backgroundColor = UIColor.sparkleBrandOrangeColor
        $0.layer.cornerRadius = 8
    }
    
    private let workspaceNameLabel = UILabel().then {
        $0.text = "워크스페이스 이름"
        $0.textColor = UIColor.sparkleTextPrimaryColor
        $0.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    private let workspaceNameTextField = UITextField().then {
        $0.placeholder = "워크스페이스 이름을 입력해주세요 (필수)"
        $0.font = UIFont.systemFont(ofSize: 13)
        $0.textColor = UIColor.sparkleTextPrimaryColor
    }
    
    private let workspaceExplanationLabel = UILabel().then {
        $0.text = "워크스페이스 설명"
        $0.textColor = UIColor.sparkleTextPrimaryColor
        $0.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    private let workspaceExplanationTextField = UITextField().then {
        $0.placeholder = "워크스페이스를 설명하세요. (옵션)"
        $0.font = UIFont.systemFont(ofSize: 13)
        $0.textColor = UIColor.sparkleTextPrimaryColor
    }
    
    private let confirmButton = UIButton().then {
        $0.setTitle("완료", for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        $0.setTitleColor(UIColor.sparkleBrandWhiteColor, for: .normal)
        $0.backgroundColor = UIColor.sparkleBrandInactiveColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func setupSubviews() {
        
        addSubview(profileImageView)
        addSubview(workspaceNameLabel)
        addSubview(workspaceNameTextField)
        addSubview(workspaceExplanationLabel)
        addSubview(workspaceExplanationTextField)
        addSubview(confirmButton)
    }
    
    override func setupLayout() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(24)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.size.equalTo(70)
        }
        
        workspaceNameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
            make.height.equalTo(24)
        }
        
        workspaceNameTextField.snp.makeConstraints { make in
            make.top.equalTo(workspaceNameLabel.snp.bottom).offset(8)
            make.height.equalTo(44)
            make.horizontalEdges.equalTo(workspaceNameLabel)
        }
        
        workspaceExplanationLabel.snp.makeConstraints { make in
            make.top.equalTo(workspaceNameTextField.snp.bottom).offset(24)
            make.height.horizontalEdges.equalTo(workspaceNameLabel)
        }
        
        workspaceExplanationTextField.snp.makeConstraints { make in
            make.top.equalTo(workspaceExplanationLabel.snp.bottom).offset(8)
            make.height.horizontalEdges.equalTo(workspaceNameTextField)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.bottom.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
        }
    }
    
}

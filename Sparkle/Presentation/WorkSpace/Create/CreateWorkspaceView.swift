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
    
    private let profileView = UIView().then {
        $0.backgroundColor = UIColor.sparkleBrandOrangeColor
        $0.layer.cornerRadius = 8
    }
    
    private let profileImageView = UIImageView().then {
        $0.image = UIImage(named: "workspaceBubble")
    }
    
    private let cameraButton = UIButton().then {
        let image = UIImage(systemName: "camera.fill",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: 14, weight: .medium))
        $0.setImage(image, for: .normal)
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.sparkleBrandWhiteColor.cgColor
        $0.backgroundColor = UIColor.sparkleBrandOrangeColor
        $0.tintColor = UIColor.sparkleBrandWhiteColor
    }
    
    private let workspaceNameLabel = UILabel().then {
        $0.text = "워크스페이스 이름"
        $0.textColor = UIColor.sparkleTextPrimaryColor
        $0.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    private let workspaceNameBackgroundView = UIView().then {
        $0.backgroundColor = UIColor.sparkleBrandWhiteColor
        $0.layer.cornerRadius = 8
    }
    
    private let workspaceNameTextField = UITextField().then {
        $0.placeholder = "워크스페이스 이름을 입력해주세요 (필수)"
        $0.font = UIFont.systemFont(ofSize: 13)
        $0.textColor = UIColor.sparkleTextPrimaryColor
        $0.backgroundColor = UIColor.sparkleBrandWhiteColor
    }
    
    private let workspaceExplanationLabel = UILabel().then {
        $0.text = "워크스페이스 설명"
        $0.textColor = UIColor.sparkleTextPrimaryColor
        $0.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    private let workspaceExplanationBackgroundView = UIView().then {
        $0.backgroundColor = UIColor.sparkleBrandWhiteColor
        $0.layer.cornerRadius = 8
    }
    
    private let workspaceExplanationTextField = UITextField().then {
        $0.placeholder = "워크스페이스를 설명하세요. (옵션)"
        $0.font = UIFont.systemFont(ofSize: 13)
        $0.textColor = UIColor.sparkleTextPrimaryColor
        $0.backgroundColor = UIColor.sparkleBrandWhiteColor
    }
    
    let confirmButton = CommonButton(image: nil, title: "완료", backgroundColor: UIColor.sparkleBrandInactiveColor, tintColor: UIColor.sparkleBrandWhiteColor, font: UIFont.boldSystemFont(ofSize: 14))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        cameraButton.layer.cornerRadius = cameraButton.frame.height / 2
        cameraButton.layer.masksToBounds = true
    }
    
    override func setupSubviews() {
        
        addSubview(profileView)
        addSubview(profileImageView)
        addSubview(cameraButton)
        addSubview(workspaceNameLabel)
        addSubview(workspaceNameBackgroundView)
        addSubview(workspaceNameTextField)
        addSubview(workspaceExplanationLabel)
        addSubview(workspaceExplanationBackgroundView)
        addSubview(workspaceExplanationTextField)
        addSubview(confirmButton)
    }
    
    override func setupLayout() {
        
        profileView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(24)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.size.equalTo(70)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(profileView).inset(10)
            make.bottom.equalTo(profileView)
        }
        
        cameraButton.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.bottom.equalTo(profileView.snp.bottom).offset(5)
            make.trailing.equalTo(profileView.snp.trailing).offset(7)
        }
        
        workspaceNameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
            make.height.equalTo(24)
        }
        
        workspaceNameBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(workspaceNameLabel.snp.bottom).offset(8)
            make.height.equalTo(44)
            make.horizontalEdges.equalTo(workspaceNameLabel)
        }
        
        workspaceNameTextField.snp.makeConstraints { make in
            make.verticalEdges.equalTo(workspaceNameBackgroundView)
            make.horizontalEdges.equalTo(workspaceNameBackgroundView).inset(12)
        }
        
        workspaceExplanationLabel.snp.makeConstraints { make in
            make.top.equalTo(workspaceNameTextField.snp.bottom).offset(24)
            make.height.horizontalEdges.equalTo(workspaceNameLabel)
        }
        
        workspaceExplanationBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(workspaceExplanationLabel.snp.bottom).offset(8)
            make.height.horizontalEdges.equalTo(workspaceNameBackgroundView)
        }
        
        workspaceExplanationTextField.snp.makeConstraints { make in
            make.verticalEdges.equalTo(workspaceExplanationBackgroundView)
            make.horizontalEdges.equalTo(workspaceExplanationBackgroundView).inset(12)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.bottom.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
        }
    }
}

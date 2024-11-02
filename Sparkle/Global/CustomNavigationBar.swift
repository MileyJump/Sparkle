//
//  CustomNavigationBar.swift
//  Sparkle
//
//  Created by 최민경 on 11/1/24.
//

import UIKit

class WorkspaceCustomNavigationBar: UIView {
    
    private let workspaceImageView: UIImageView
    
    private let titleLabel = UILabel().then {
        $0.textColor = UIColor.sparkleTextPrimaryColor
        $0.font = UIFont.boldSystemFont(ofSize: 22)
        $0.textAlignment = .left
    }
    
    private let profileImageView: UIImageView
    
    init(workspaceImageName: String, title: String, profileImageName: String) {
        
        self.workspaceImageView = UIImageView(image: UIImage(named: workspaceImageName))
        self.profileImageView = UIImageView(image: UIImage(named: profileImageName))
        
        super.init(frame: .zero)
        
        setupAppearance()
        setupLayout()
        
        titleLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        workspaceImageView.layer.cornerRadius = 8
        workspaceImageView.layer.masksToBounds = true
        
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        profileImageView.layer.masksToBounds = true
    }
    
    private func setupAppearance() {
        
        workspaceImageView.contentMode = .scaleAspectFill
        profileImageView.contentMode = .scaleAspectFill
    }
    
    private func setupLayout() {
        
        addSubview(workspaceImageView)
        addSubview(titleLabel)
        addSubview(profileImageView)
        
        workspaceImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
            make.size.equalTo(32)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(workspaceImageView.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
            
        }
        
        profileImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(16)
            make.size.equalTo(32)
        }
    }
}

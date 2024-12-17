//
//  ChannelSettingCollectionViewCell.swift
//  Sparkle
//
//  Created by 최민경 on 12/17/24.
//

import UIKit
import SnapKit
import Then

class ChannelSettingCollectionViewCell: BaseCollectionViewCell {
    
    private let profileImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        $0.image = UIImage(named: "Profile1")
    }
    
    private let nameLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12)
        $0.textAlignment = .center
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupSubviews() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
    }
    
    override func setupLayout() {
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(48)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview()
        }
    }
    
    func bind(_ member: UserMemberResponse) {
        
        nameLabel.text = member.nickname
    }
}

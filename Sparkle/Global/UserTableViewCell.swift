//
//  UserTableViewCell.swift
//  Sparkle
//
//  Created by 최민경 on 11/6/24.
//

import UIKit

final class UserTableViewCell: BaseCollectionViewCell {
    
    private let profileImageView = UIImageView()
    private let nameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func setupSubviews() {
        addSubview(profileImageView)
        addSubview(nameLabel)
    }
    
    override func setupLayout() {
        
        profileImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(14)
            make.verticalEdges.equalToSuperview().inset(8)
            make.size.equalTo(44)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.verticalEdges.equalTo(profileImageView.snp.top).inset(4)
            make.leading.equalTo(profileImageView.snp.trailing).offset(8)
        }
    }
}


//
//  ChannelChattingCell.swift
//  Sparkle
//
//  Created by 최민경 on 11/13/24.
//

import UIKit

import Then
import SnapKit

final class ChannelChattingCell: BaseTableViewCell {
    
    private let profileImageView = UIImageView().then {
        $0.backgroundColor = .blue
    }
    
    private let nicknameLabel = UILabel().then {
        $0.text = "옹졸한 마일리"
    }
    
    private let chatBackgroundView = UIView().then {
        $0.backgroundColor = .yellow
    }
    
    private let chatLabel = UILabel().then {
        $0.text = "채팅이 들어갈 거에요"
    }
    
    private let timeLabel = UILabel().then {
        $0.text = "10:10"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func setupSubviews() {
        addSubview(profileImageView)
        addSubview(nicknameLabel)
        addSubview(chatLabel)
        addSubview(timeLabel)
    }
    
    override func setupLayout() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(6)
            make.leading.equalTo(safeAreaLayoutGuide)
            make.size.equalTo(34)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.top)
            make.leading.equalTo(profileImageView.snp.trailing).offset(8)
        }
        
//        chatBackgroundView.snp.makeConstraints { make in
//            make.top.equalTo(nicknameLabel.snp.bottom).offset(5)
//            make.
//        }
//        
//        chatLabel.snp.makeConstraints { make in
//            make.top.equalTo(nicknameLabel.snp.bottom).offset(5)
//            make.leading.equalTo(profileImageView.snp.trailing).offset(8)
//        }
        
        
    }
    
    func bind(_ channel: ChatTable) {
        print("아아아아아아앍💖💖💖💖")
    }
    
}

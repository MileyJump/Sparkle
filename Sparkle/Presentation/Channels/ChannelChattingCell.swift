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
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    }
    
    private let nicknameLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textColor = .sparkleTextPrimaryColor
    }
    
    private let chatBackgroundView = UIView().then {
        $0.backgroundColor = .yellow
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = true
    }
    
    private let chatLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.font = UIFont.systemFont(ofSize: 13)
        $0.textColor = .sparkleTextPrimaryColor
    }
    
    private let timeLabel = UILabel().then {
        $0.text = "10:10"
        $0.font = UIFont.systemFont(ofSize: 11)
        $0.textColor = .sparkleTextSecondaryColor
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func setupSubviews() {
        addSubview(profileImageView)
        addSubview(nicknameLabel)
        addSubview(chatBackgroundView)
        addSubview(chatLabel)
        addSubview(timeLabel)
    }
    
    override func setupLayout() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(6)
            make.leading.equalToSuperview()
            make.size.equalTo(34)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.top)
            make.leading.equalTo(profileImageView.snp.trailing).offset(8)
        }
        
        chatBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(5)
            make.leading.equalTo(profileImageView.snp.trailing).offset(8)
//            make.trailing.lessThanOrEqualTo(timeLabel.snp.leading).offset(-8)
            make.trailing.equalTo(timeLabel.snp.leading).offset(-8)
            make.bottom.equalToSuperview().inset(6)
        }
        
        chatLabel.snp.makeConstraints { make in
            make.edges.equalTo(chatBackgroundView).inset(8)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.bottom.equalTo(chatBackgroundView)
            make.trailing.equalToSuperview().inset(10)
        }
        
        
    }
    
    func bind(_ channel: ChatTable) {
        profileImageView.image = UIImage(named: "Profile1")
        nicknameLabel.text = channel.user?.nickname
        chatLabel.text = channel.chatContent
        timeLabel.text = formatTime(channel.chatCreateAt)
    }
    
    private func formatTime(_ dateString: String) -> String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds] // ISO 8601 형식 지원
        
        let displayFormatter = DateFormatter()
        displayFormatter.dateFormat = "hh:mm a"
        displayFormatter.locale = Locale(identifier: "ko_KR")

        if let date = isoFormatter.date(from: dateString) {
            return displayFormatter.string(from: date)
        }
        return dateString
    }
}

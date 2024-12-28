//
//  ChannelsTableViewCell.swift
//  Sparkle
//
//  Created by 최민경 on 11/24/24.
//

import UIKit

import SnapKit
import Then

final class ChannelsTableViewCell: BaseTableViewCell {
    
    private let hashIconLabel = UILabel()
    
    private let channelNameLabel = UILabel().then {
        $0.textColor = .sparkleTextPrimaryColor
        $0.font = UIFont.systemFont(ofSize: 13)
    }
    
    private let countLabelBackgorundView = UIView().then {
        $0.backgroundColor = .sparkleBrandOrangeColor
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        $0.isHidden = true
    }
    
    private let countLabel = UILabel().then {
        $0.textColor = .sparkleBrandWhiteColor
        $0.font = UIFont.systemFont(ofSize: 12)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func setupSubviews() {
        
        addSubview(hashIconLabel)
        addSubview(channelNameLabel)
        addSubview(countLabelBackgorundView)
        addSubview(countLabel)
    }
    
    override func setupLayout() {
        
        hashIconLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(14)
            make.verticalEdges.equalToSuperview().inset(8)
//            make.size.equalTo(44)
        }
        
        channelNameLabel.snp.makeConstraints { make in
            make.verticalEdges.equalTo(hashIconLabel).inset(4)
            make.leading.equalTo(hashIconLabel.snp.trailing).offset(8)
        }
        
        countLabelBackgorundView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(17)
            make.centerY.equalToSuperview()
//            make.height.equalTo(14)
        }
        
        countLabel.snp.makeConstraints { make in
            make.verticalEdges.equalTo(countLabelBackgorundView).inset(4)
            make.horizontalEdges.equalTo(countLabelBackgorundView).inset(8)
        }
    }
    
    override func setupUI() {
        hashIconLabel.text = "#"
        channelNameLabel.text = "오픈라운지"
//        channelNameLabel.backgroundColor = .red
    }
    
    func bind(channel: ChannelResponse) {
        channelNameLabel.text = channel.name
    }
    
}

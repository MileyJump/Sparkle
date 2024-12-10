//
//  ChannelChattingView.swift
//  Sparkle
//
//  Created by 최민경 on 11/13/24.
//

import UIKit

import Then
import SnapKit

final class ChannelChattingView: BaseView {
    
    let channelTableView = UITableView().then {
        $0.register(ChannelChattingCell.self, forCellReuseIdentifier: ChannelChattingCell.identifier)
        $0.separatorStyle = .none
        $0.allowsSelection = false
        $0.backgroundColor = .blue
    }
    
    let messageBackgourndView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    let messageInputView = UIView().then {
        $0.backgroundColor = .sparkleBackgroundPrimaryColor
        $0.layer.cornerRadius = 8
    }

    
    let messageTextView = UITextView().then {
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textColor = .sparkleTextSecondaryColor
        $0.backgroundColor = .sparkleBackgroundPrimaryColor
        $0.isScrollEnabled = false
        $0.text = "메세지를 입력하세요"
    }
    
    let sendButton = UIButton(type: .system).then {
        $0.setImage(UIImage(systemName: "paperplane"), for: .normal)
        $0.tintColor = .sparkleTextSecondaryColor
    }
    
    private let plusButton = UIButton().then {
        $0.setImage(UIImage(systemName: "plus"), for: .normal)
        $0.tintColor = .sparkleTextSecondaryColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func setupSubviews() {
        addSubview(channelTableView)
        addSubview(messageBackgourndView)
        addSubview(messageInputView)
        addSubview(messageTextView)
        addSubview(plusButton)
        addSubview(sendButton)
    }
    
    override func setupLayout() {
        
        channelTableView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(messageBackgourndView.snp.top)
        }
        
        messageBackgourndView.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.greaterThanOrEqualTo(58)
        }
        
        messageInputView.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(50)
            make.horizontalEdges.equalTo(messageBackgourndView).inset(16)
            make.top.equalTo(messageBackgourndView.snp.top).inset(8)
            make.bottom.equalTo(messageBackgourndView.snp.bottom).inset(12)
        }
        
        plusButton.snp.makeConstraints { make in
            make.centerY.equalTo(messageInputView)
            make.leading.equalTo(messageInputView.snp.leading).inset(12)
            make.height.equalTo(20)
            make.width.equalTo(22)
        }
        
        sendButton.snp.makeConstraints { make in
            make.trailing.equalTo(messageInputView).inset(12)
            make.centerY.equalTo(messageInputView)
//            make.width.equalTo(30)
//            make.height.equalTo(50)
            make.size.equalTo(24)
        }
        
        messageTextView.snp.makeConstraints { make in
            make.leading.equalTo(plusButton.snp.trailing).offset(8)
            make.verticalEdges.equalTo(messageInputView).inset(10)
            make.trailing.equalTo(sendButton.snp.leading).offset(-8)
        }
    }
}

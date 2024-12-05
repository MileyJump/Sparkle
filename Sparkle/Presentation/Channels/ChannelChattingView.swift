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
        $0.backgroundColor = .white
    }
    
    let messageInputView = UIView().then {
        $0.backgroundColor = .lightGray
    }
    
    let messageTextView = UITextView().then {
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textColor = .black
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
        $0.isScrollEnabled = false
    }
    
    let sendButton = UIButton(type: .system).then {
        $0.setTitle("Send", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
    }
    
    private let plusButton = UIButton().then {
        $0.setImage(UIImage(systemName: "plus"), for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func setupSubviews() {
        addSubview(channelTableView)
        addSubview(messageInputView)
        addSubview(messageTextView)
        addSubview(plusButton)
        addSubview(sendButton)
    }
    
    override func setupLayout() {
        
        channelTableView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(messageInputView.snp.top)
        }
        
        messageInputView.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalToSuperview()
            make.height.greaterThanOrEqualTo(50)
        }
        
        messageTextView.snp.makeConstraints { make in
            make.leading.equalTo(plusButton.snp.trailing).inset(8)
            make.verticalEdges.equalTo(messageInputView).inset(10)
            make.trailing.equalTo(sendButton.snp.leading).offset(-8)
        }
        
        plusButton.snp.makeConstraints { make in
            make.centerY.equalTo(messageTextView)
            make.leading.equalTo(messageTextView).inset(12)
            make.height.equalTo(20)
            make.width.equalTo(22)
        }
        
        sendButton.snp.makeConstraints { make in
            make.trailing.equalTo(messageInputView).inset(12)
            make.centerY.equalTo(messageTextView)
            make.size.equalTo(24)
        }
    }
}

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
    
    private let channelTableView = UITableView().then {
        $0.backgroundColor = .blue
    }

    private let sendTextFieldBackgournd = UIView().then {
        $0.backgroundColor = .sparkleBackgroundSecondaryColor
        $0.layer.cornerRadius = 8
    }
    
    private let inputTextField = UITextField().then {
        $0.placeholder = "메세지를 입력하세요."
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func setupSubviews() {
        addSubview(channelTableView)
        addSubview(sendTextFieldBackgournd)
        addSubview(inputTextField)
    }
    
    override func setupLayout() {
        sendTextFieldBackgournd.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(16)
        }
        
        channelTableView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            
        }
    }
    
    
}

//
//  PopUPView.swift
//  Sparkle
//
//  Created by 최민경 on 12/28/24.
//

import UIKit

import Then
import SnapKit

class PopUPView: BaseView {
    
    let titleLabel = UILabel().then {
        $0.text = "채널 참여"
        $0.textColor = .sparkleBrandBlackColor
        $0.font = UIFont.boldSystemFont(ofSize: 13)
        $0.textAlignment = .center
    }
    
    let subTitleLabel = UILabel().then {
        $0.text = "[일반] 채널에 참여하시겠습니까?"
        $0.textColor = .sparkleTextSecondaryColor
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textAlignment = .center
    }
    
    let cancelButton = UIButton().then {
        $0.backgroundColor = .sparkleBrandInactiveColor
        $0.setTitleColor(.sparkleBrandWhiteColor, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        $0.setTitle("취소", for: .normal)
    }
    
    let comfirmButton = UIButton().then {
        $0.backgroundColor = .sparkleBrandOrangeColor
        $0.setTitleColor(.sparkleBrandWhiteColor, for: .normal)
        $0.setTitle("확인", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 12)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func setupSubviews() {
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        addSubview(cancelButton)
        addSubview(comfirmButton)
    }
    
    override func setupLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(5)
            make.centerX.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        
        
    }
}

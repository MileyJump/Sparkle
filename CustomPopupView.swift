//
//  CustomPopupView.swift
//  Sparkle
//
//  Created by 최민경 on 11/5/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class CustomPopupView: UIView {
    
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let messageLabel = UILabel()
    private let confirmedButton = UIButton()
    private let cancelButton = UIButton()
    
    let confirmedButtonTapped = PublishSubject<Void>()
    let cancelButtonTapped = PublishSubject<Void>()
    
    private let disposeBag = DisposeBag()
    
    init(title: String, message: String) {
        super.init(frame: UIScreen.main.bounds)
        setupUI(title: title, message: message)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI(title: "", message: "")
    }
    
    func setupUI(title: String, message: String) {
        setupSubviews()
        setupLayout()
        
        // 타이틀 설정
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textAlignment = .center
        
        // 메시지 설정
        messageLabel.text = message
        messageLabel.font = UIFont.systemFont(ofSize: 16)
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        
        // 버튼 설정
        confirmedButton.setTitle("확인", for: .normal)
        confirmedButton.setTitleColor(.blue, for: .normal)
        confirmedButton.layer.cornerRadius = 8
        confirmedButton.layer.borderWidth = 1
        confirmedButton.layer.borderColor = UIColor.blue.cgColor
        
        cancelButton.setTitle("취소", for: .normal)
        cancelButton.setTitleColor(.blue, for: .normal)
        cancelButton.layer.cornerRadius = 8
        cancelButton.layer.borderWidth = 1
        cancelButton.layer.borderColor = UIColor.blue.cgColor
        
        bindUI()
    }
    
    func setupSubviews() {
        addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(messageLabel)
        containerView.addSubview(confirmedButton)
        containerView.addSubview(cancelButton)
    }
    
    func setupLayout() {
        containerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(20)
            make.horizontalEdges.equalTo(containerView.snp.horizontalEdges).inset(16)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(containerView.snp.horizontalEdges).inset(16)
        }
        
        confirmedButton.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(20)
            make.bottom.equalTo(containerView.snp.bottom).offset(-20)
            make.height.equalTo(44)  // 버튼 높이는 고정
        }
        
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(20)
            make.bottom.equalTo(containerView.snp.bottom).offset(-20)
            make.height.equalTo(44)
            make.leading.equalTo(confirmedButton.snp.trailing).offset(20)
            make.trailing.equalTo(containerView.snp.trailing).offset(-16)
            make.width.equalTo(confirmedButton.snp.width)
        }
    }
    
    // 버튼 클릭 이벤트와 외부 연동
    func bindUI() {
        confirmedButton.rx.tap
            .bind(to: confirmedButtonTapped)
            .disposed(by: disposeBag)
        
        cancelButton.rx.tap
            .bind(to: cancelButtonTapped)
            .disposed(by: disposeBag)
    }
    
    // 팝업 애니메이션
    func show(in view: UIView) {
        view.addSubview(self)
        containerView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        containerView.alpha = 0
        
        // 애니메이션
        UIView.animate(withDuration: 0.3) {
            self.containerView.transform = CGAffineTransform.identity
            self.containerView.alpha = 1
        }
    }
    
    func dismiss() {
        UIView.animate(withDuration: 0.3, animations: {
            self.containerView.alpha = 0
        }) { _ in
            self.removeFromSuperview()
        }
    }
}

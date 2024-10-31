//
//  BaseView.swift
//  Sparkle
//
//  Created by 최민경 on 10/31/24.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupLayout()
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() { }
    
    func setupLayout() { }
    
    func setupUI() {
        backgroundColor = .white
    }
}

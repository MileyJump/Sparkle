//
//  BaseViewController.swift
//  Sparkle
//
//  Created by 최민경 on 10/31/24.
//

import UIKit

class BaseViewController<RootView: UIView>: UIViewController {
    
    let rootView = RootView()
    
    override func loadView() {
        view = rootView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
    }
    
    
    func setupUI() {
        navigationItem.backButtonTitle = ""
        view.backgroundColor = .white
    }
    
    func setupNavigationBar() { }
}


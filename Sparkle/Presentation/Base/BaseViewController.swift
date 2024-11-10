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
    
    func setupNavigationBar() {
        navigationItem.title = navigationItem.title ?? "기본 타이틀"
        let imageName = "xmark"
        
        let xmarkBarButtonItem = UIBarButtonItem(image: UIImage(systemName: imageName), style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem = xmarkBarButtonItem
        xmarkBarButtonItem.tintColor = UIColor.sparkleTextPrimaryColor
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.shadowColor = .lightGray
        appearance.backgroundColor = UIColor.secondarySystemBackground
        navigationController?.navigationBar.tintColor = UIColor.sparkleTextPrimaryColor
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    func setNavigationBarTitleAndImage(title: String, imageName: String) {
        navigationItem.title = title
        let xmarkBarButtonItem = UIBarButtonItem(image: UIImage(systemName: imageName), style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem = xmarkBarButtonItem
    }
}

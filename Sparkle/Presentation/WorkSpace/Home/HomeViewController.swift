//
//  HomeViewController.swift
//  Sparkle
//
//  Created by 최민경 on 10/30/24.
//

import UIKit
import RxSwift

final class HomeViewController: BaseViewController<HomeView> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupNavigationBar() {
        navigationItem.title = "시작하기"
        
        let xmarkBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem = xmarkBarButtonItem
        xmarkBarButtonItem.tintColor = UIColor.sparkleTextPrimaryColor
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.shadowColor = .lightGray
        appearance.backgroundColor = UIColor.secondarySystemBackground
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
}

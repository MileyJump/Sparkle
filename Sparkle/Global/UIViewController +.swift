//
//  UIViewController +.swift
//  Sparkle
//
//  Created by 최민경 on 11/2/24.
//

import UIKit

extension UIViewController {
    // MARK: - Custom Navigation Bar
    
    func workspaceNavigationBar(workspaceImageName: String, title: String, profileImageName: String) {
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 20, height: 44))
    }
    
    func addSearchNavigationBar(searchBarText: String = "", firstButtonImageName: String, secondButtonImageName: String) {
        // 커스텀 네비 바의 배경이 될 UIView
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 20, height: 44))
        
        // 서치 바
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: customView.frame.width - 80, height: 44))
        searchBar.placeholder = searchBarText
        customView.addSubview(searchBar)
        
        // 첫번째 버튼
        let firstButton = UIButton(type: .system)
        firstButton.setImage(UIImage(systemName: firstButtonImageName), for: .normal)
        firstButton.tintColor = .black
        firstButton.frame = CGRect(x: customView.frame.width - 80, y: 0, width: 40, height: 44)
        customView.addSubview(firstButton)
        
        // 두번째 버튼
        let secondButton = UIButton(type: .system)
        secondButton.setImage(UIImage(systemName: secondButtonImageName), for: .normal)
        secondButton.tintColor = .black
        secondButton.frame = CGRect(x: customView.frame.width - 40, y: 0, width: 40, height: 44)
        customView.addSubview(secondButton)

        self.navigationItem.titleView = customView
        self.navigationController?.navigationBar.backgroundColor = .white
      }
    
}

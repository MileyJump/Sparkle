//
//  MainTabBarViewController.swift
//  Sparkle
//
//  Created by 최민경 on 10/30/24.
//

import UIKit

final class SparkleTabBarController: UITabBarController {
    
//    var workspace: WorkspaceListCheckResponse
//    
//    init(workspace: WorkspaceListCheckResponse) {
//        self.workspace = workspace
//        super.init(nibName: nil, bundle: nil)
//    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabs: [SparkleTabBar] = [.mainHome, .direct, .search, .setting]
        
        var viewControllers: [UIViewController] = []
        
        for (index, tabBar) in tabs.enumerated() {
            let vc = tabBar.viewController
            let nav = UINavigationController(rootViewController: vc)
            nav.tabBarItem = UITabBarItem(title: tabBar.title, image: tabBar.image, tag: index)
            nav.tabBarItem.selectedImage = tabBar.seletedImage
            viewControllers.append(nav)
        }
        
        setViewControllers(viewControllers, animated: true)
        
        tabBar.tintColor = UIColor.sparkleBrandBlackColor
        tabBar.unselectedItemTintColor = UIColor.sparkleBrandInactiveColor
        
    }
}


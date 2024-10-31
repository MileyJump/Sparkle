//
//  MainTabBarViewController.swift
//  Sparkle
//
//  Created by 최민경 on 10/30/24.
//

import UIKit

final class SparkleTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabs: [SparkleTabBar] = [.mainHome, .direct, .setting]
        
        var viewControllers: [UIViewController] = []
        
        for (index, tabBar) in tabs.enumerated() {
            let vc = tabBar.viewController
            let nav = UINavigationController(rootViewController: vc)
            nav.tabBarItem = UITabBarItem(title: tabBar.title, image: tabBar.image, selectedImage: tabBar.seletedImage)
            nav.navigationBar.tag = index
            viewControllers.append(nav)
        }
        
        setViewControllers(viewControllers, animated: true)
        
        tabBar.tintColor = UIColor.sparkleBrandWhiteColor
        tabBar.unselectedItemTintColor = UIColor.sparkleBrandGrayColor

    }
}


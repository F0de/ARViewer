//
//  TabBarController.swift
//  AR Viewer
//
//  Created by Влад Тимчук on 17.09.2023.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // ARView Tab
        let arViewTab = ARViewController()
        let arViewTabBarItem = UITabBarItem(title: "AR", image: UIImage(systemName: "arkit"), tag: 0)
        arViewTab.tabBarItem = arViewTabBarItem
        
        // ListView Tab
        let listViewTab = UINavigationController(rootViewController: ListViewController())
        let listViewtabBarItem = UITabBarItem(title: "List", image: UIImage(systemName: "list.bullet"), tag: 1)
        listViewTab.tabBarItem = listViewtabBarItem
        
        viewControllers = [arViewTab, listViewTab]
        tabBar.tintColor = UIColor.systemYellow
//        tabBar.unselectedItemTintColor = UIColor(hex: "999999")
//        tabBar.backgroundColor = UIColor(hex: "161616", alpha: 0.94)
        tabBar.backgroundColor = .tertiarySystemBackground
        
    }
    
}

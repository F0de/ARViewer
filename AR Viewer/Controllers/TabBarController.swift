//
//  TabBarController.swift
//  AR Viewer
//
//  Created by Влад Тимчук on 17.09.2023.
//

import UIKit
import SwiftUI
import RealmSwift

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
        @ObservedResults(Folder.self) var folders
        
        func createDB() -> Folder {
            let folder = Folder()
            folder.name = "startFolder"
            $folders.append(folder)
            return folders.first!
        }
        
        let listViewTab = UIHostingController(rootView: ListView(folder: folders.first ?? createDB()))
        let listViewTabBarItem = UITabBarItem(title: "List", image: UIImage(systemName: "list.bullet"), tag: 1)
        listViewTab.tabBarItem = listViewTabBarItem
        
        viewControllers = [arViewTab, listViewTab]
        tabBar.tintColor = UIColor.systemYellow
//        tabBar.unselectedItemTintColor = UIColor(hex: "999999")
//        tabBar.backgroundColor = UIColor(hex: "161616", alpha: 0.94)
        tabBar.backgroundColor = .tertiarySystemBackground
        
    }
    
}

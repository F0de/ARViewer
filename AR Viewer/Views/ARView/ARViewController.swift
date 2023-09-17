//
//  ViewController.swift
//  AR Viewer
//
//  Created by Влад Тимчук on 16.09.2023.
//

import UIKit
import SnapKit

class ARViewController: UIViewController {
    //MARK: - Properties
    private lazy var tabBar = UITabBar()
    
    //MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    //MARK: - Setup Views Methods
    func setupTabBar() {
        
    }
    
    //MARK: - Setting Views
    func setupViews() {
        setupTabBar()
        
        addSubViews()
        
        setupLayout()

    }
    //MARK: - Setting
    func addSubViews() {
        view.addSubview(tabBar)
    }
    //MARK: - Layout
    func setupLayout() {
        tabBar.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
        }
    }
}

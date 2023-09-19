//
//  ViewController.swift
//  AR Viewer
//
//  Created by Влад Тимчук on 16.09.2023.
//

import UIKit
import ARKit
import SnapKit

class ARViewController: UIViewController {
    //MARK: - Properties
    private lazy var sceneView = ARSCNView()
    
    //MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpSceneView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    //MARK: - Setup Views Methods
    func setUpSceneView() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical]
        
        sceneView.session.run(configuration)
        
        sceneView.delegate = self
        sceneView.debugOptions = .showFeaturePoints
    }
    
    //MARK: - Setting Views
    func setupViews() {
        
        addSubViews()
        
        setupLayout()

    }
    //MARK: - Setting
    func addSubViews() {
        view.addSubview(sceneView)
    }
    //MARK: - Layout
    func setupLayout() {
        sceneView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.bottom.equalToSuperview()
        }
        
    }
}

extension ARViewController: ARSCNViewDelegate {
    
}

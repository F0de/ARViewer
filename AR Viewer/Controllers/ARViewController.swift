//
//  ViewController.swift
//  AR Viewer
//
//  Created by Влад Тимчук on 16.09.2023.
//

import UIKit
import SwiftUI
import ARKit
import RealityKit
import SnapKit
import Combine

class ARViewController: UIViewController {
    //MARK: - Properties
    private let manager = APIManager.shared

    private lazy var arView = ARView()
    private var cancellables = Set<AnyCancellable>()
    
    deinit {
        print("deinit")
        cancellables.forEach { $0.cancel() }
    }
    
    //MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(handleTap(recognizer: )))
        arView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setUpSceneView()
        
//        manager.$modelEntity
//            .sink { [weak self] updateModelEntity in
//                guard let strongSelf = self else { return }
//                strongSelf.spawnObjectOnSurface(modelEntity: updateModelEntity)
//            }
//            .store(in: &cancellables)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        arView.session.pause()
    }
    
    //MARK: - Setup Views Methods
    private func setUpSceneView() {
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        if #available(iOS 16, *) {
            if config.videoFormat.isVideoHDRSupported {
                config.videoHDRAllowed = true
            }
        }
        arView.session.run(config)
        arView.debugOptions = .showFeaturePoints
    }
    
    @objc private func handleTap(recognizer: UITapGestureRecognizer) {
        let location = recognizer.location(in: arView)
        
        let results = arView.raycast(
            from: location,
            allowing: .estimatedPlane,
            alignment: .any)
        guard let firstResult = results.first else { return }
        
        if let anchor = firstResult.anchor {
            //TODO: delete object
            
        } else {
            let anchor = ARAnchor(transform: firstResult.worldTransform)
    //        arView.scene.anchors.removeAll()
            arView.session.add(anchor: anchor)
            
            let anchorEntity = AnchorEntity(anchor: anchor)
            anchorEntity.addChild(manager.modelEntity)
            
            arView.scene.addAnchor(anchorEntity)
        }
    }
    
    //MARK: - Setting Views
    func setupViews() {
        
        addSubViews()
        
        setupLayout()

    }
    //MARK: - Setting
    func addSubViews() {
        view.addSubview(arView)
    }
    //MARK: - Layout
    func setupLayout() {
        arView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.bottom.equalToSuperview()
        }
        
    }
}

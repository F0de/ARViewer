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
    private lazy var removeAllButton = UIButton(type: .system)
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
            action: #selector(spawnObject(recognizer: )))
        arView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setUpSceneView()
        
//        // auto adding object when he updated in manager
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
        arView.enableObjectRemoval()
    }
    
    @objc private func spawnObject(recognizer: UITapGestureRecognizer) {
        let location = recognizer.location(in: arView)
        
        let results = arView.raycast(from: location, allowing: .estimatedPlane, alignment: .any)
        guard let firstResult = results.first else { return }
        
        // placing
        let anchor = ARAnchor(transform: firstResult.worldTransform)
        arView.session.add(anchor: anchor)
        
//        let anchorEntity = AnchorEntity(anchor: anchor)
        let anchorEntity = AnchorEntity()
        anchorEntity.name = manager.modelEntity.name
        anchorEntity.addChild(manager.modelEntity)
        arView.scene.addAnchor(anchorEntity)
        
        // movement
        manager.modelEntity.generateCollisionShapes(recursive: true)
        arView.installGestures(.all, for: manager.modelEntity)
    }
    
    private func setupRemoveAllUIButton() {
        removeAllButton.backgroundColor = .systemYellow
        removeAllButton.layer.cornerRadius = 16
        removeAllButton.setTitle("Remove All", for: .normal)
        removeAllButton.titleLabel?.font = UIFont(name: "FixelText-SemiBold", size: 18)
        removeAllButton.tintColor = .white
        removeAllButton.addTarget(self, action: #selector(didTapRemoveAllButton), for: .touchUpInside)
    }
    
    //MARK: - Setting Views
    func setupViews() {
        
        setupRemoveAllUIButton()
        
        addSubViews()
        
        setupLayout()

    }
    //MARK: - Setting
    func addSubViews() {
        view.addSubview(arView)
        view.addSubview(removeAllButton)
    }
    //MARK: - Layout
    func setupLayout() {
        arView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.bottom.equalToSuperview()
        }
        
        removeAllButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-15)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-15)
            make.height.equalTo(50)
        }
        
    }
    
    //MARK: - Actions
    @objc private func didTapRemoveAllButton() {
        arView.scene.anchors.removeAll()
    }
}

//
//  ARView.swift
//  AR Viewer
//
//  Created by Влад Тимчук on 16.12.2023.
//

import SwiftUI
import ARKit
import RealityKit

struct ARView: View {
    @State var arView = RealityKit.ARView()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ARViewContainer(arView: $arView)
                .ignoresSafeArea()
            RemoveAllButton(arView: $arView)
        }
    }
}

struct RemoveAllButton: View {
    @Binding var arView: RealityKit.ARView

    var body: some View {
        Button {
            arView.scene.anchors.removeAll()
        } label: {
            Text("Remove All")
                .font(.custom("FixelText-SemiBold", size: 18))
                .frame(height: 35)
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.borderedProminent)
        .tint(.yellow)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding()
    }
}

struct ARViewContainer: UIViewRepresentable {
    @Binding var arView: RealityKit.ARView
    
    func makeUIView(context: Context) -> RealityKit.ARView {
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
        context.coordinator.view = arView
        arView.addGestureRecognizer(UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.spawnObject)))
        
        return arView
    }
    
    func updateUIView(_ uiView: RealityKit.ARView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
}

class Coordinator: NSObject {
    private let manager = APIManager.shared
    
    weak var view: RealityKit.ARView?
    
    @objc func spawnObject(_ recognizer: UITapGestureRecognizer) {
        guard let arView = view else { return }
        
        let location = recognizer.location(in: arView)
        
        let results = arView.raycast(from: location, allowing: .estimatedPlane, alignment: .any)
        guard let firstResult = results.first else { return }
        
        // placing
        let anchor = ARAnchor(transform: firstResult.worldTransform)
        arView.session.add(anchor: anchor)
        
        let anchorEntity = AnchorEntity(anchor: anchor)
        anchorEntity.name = manager.modelEntity.name
        anchorEntity.addChild(manager.modelEntity)
        arView.scene.addAnchor(anchorEntity)
        
        // movement
        manager.modelEntity.generateCollisionShapes(recursive: true)
        arView.installGestures(.all, for: manager.modelEntity)
    }
}

#Preview {
    ARView()
}

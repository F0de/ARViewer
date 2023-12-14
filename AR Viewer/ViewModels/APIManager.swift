//
//  APIManager.swift
//  AR Viewer
//
//  Created by Влад Тимчук on 23.09.2023.
//

import Firebase
import FirebaseStorage
import RealmSwift
import ARKit
import RealityKit

final class APIManager: ObservableObject {
    static let shared = APIManager() // Singleton
    private init() { }
    
    @Published var modelEntity = ModelEntity()

    //MARK: - Realm MongoDB
    func getPath(for folder: Folder) -> String {
        var path = String()
        if let parentFolder = folder.folder.first {
            path += getPath(for: parentFolder) + "/\(folder.name)"
        }
        return path
    }
    
    //MARK: - Firebase Storage
    let storageRef = Storage.storage().reference()
    
    //MARK: Adding model file from iPhone file system to Firebase Storage
    func addModel(_ modelName: String, to folder: Folder, fileURL: URL) -> String {
        print("path: startFolder" + getPath(for: folder))
        let folderRef = storageRef.child("startFolder" + getPath(for: folder))
        
        let serialQueue = DispatchQueue(label: "uploadSceneToFBStorage.serial-queue", qos: .utility)

        fileURL.startAccessingSecurityScopedResource()
        
        // convert URL to Data
        do {
            let data = try Data(contentsOf: fileURL)
            
            // upload scene data to FB Storage
            serialQueue.async {
                folderRef.child("\(modelName).usdz").putData(data) { result in
                    switch result {
                    case .success:
                        print("[FB Storage] File load to FB successfully")
                    case .failure(let error):
                        print("[FB Storage] Error loading file to FB. Error: \(error.localizedDescription)")
                    }
                }
            }

        } catch {
            print("Error converting URL to Data. Error: \(error)")
        }
        
        fileURL.stopAccessingSecurityScopedResource()
        
        return "startFolder" + getPath(for: folder)
    }
    
    //MARK: Deleting model file from Firebase Storage
    func deleteModel(_ model: ARModel) {
        let modelRef = storageRef.child(model.ref).child("\(model.name).usdz")
        let serialQueue = DispatchQueue(label: "deletingScene.serial-queue", qos: .utility)
        
        // deleting scene from FB Storage
        serialQueue.sync {
            modelRef.delete { error in
                if let error = error {
                    print("[FB Storage] Error deleting file. Error: \(error)")
                } else {
                    print("[FB Storage] File deleted successfully")
                }
            }
        }
        print("Deleted \(model.name) from picturesDic")
    }
    
    //MARK: Getting model files from Firebase Storage
    func getModel(_ model: ARModel) {
        let modelRef = storageRef.child(model.ref).child("\(model.name).usdz")
        print("ref to get model: \(modelRef)")
        
        let serialQueue = DispatchQueue(label: "downloadSceneFromFBStorage.serial-queue", qos: .utility)
        serialQueue.async {
            // download scene url from FB Storage
            modelRef.getData(maxSize: 100 * 1024 * 1024) { data, error in
                if let error = error {
                    print("[FB Storage] Error downloading file. \(error)")
                }
                print("[FB Storage] Successfully download file.")
                
                if let usdzData = data {
                    do {
                        let temporaryURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("\(model.name).usdz")
                        try usdzData.write(to: temporaryURL)
                        
                        let loadedEntity = try ModelEntity.loadModel(contentsOf: temporaryURL)
                        loadedEntity.name = model.name
                        
                        DispatchQueue.main.async { [weak self] in
                            guard let strongSelf = self else { return }                            
                            strongSelf.modelEntity = loadedEntity
                        }
                    } catch {
                        print("Failed to load model from data: \(error)")
                    }
                }
            }
        }
    }
    
}

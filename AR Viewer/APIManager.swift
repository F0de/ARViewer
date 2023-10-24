//
//  APIManager.swift
//  AR Viewer
//
//  Created by Влад Тимчук on 23.09.2023.
//

import Foundation
import Firebase
import FirebaseStorage
import RealmSwift

final class APIManager: ObservableObject {
    
    //MARK: - Realm MongoDB
    func getPath(for folder: Folder) -> String {
        var path = String()
        if let parentFolder = folder.folder.first {
            path += getPath(for: parentFolder) + "\(parentFolder.name)/\(folder.name)"
        }
        return path
    }
    
    //MARK: - Firebase Storage
    let storageRef = Storage.storage().reference()
    
    //MARK: Adding model file from iPhone file system to Firebase Storage
    func addModel(_ modelName: String, to folder: Folder, fileURL: URL) -> String {
        print("path: " + getPath(for: folder))
        let folderRef = storageRef.child(getPath(for: folder))
        
        folderRef.putFile(from: fileURL, metadata: nil) { metadata, error in
            if let error = error {
                print("Error loading file: \(error)")
            } else {
                print("File load succesfully")
            }
        }
        return getPath(for: folder)
    }
    
    //MARK: Getting model files from Firebase Storage
    func getModel(_ modelName: String, format: String, parent: String, completion: @escaping (Data?) -> Void) {
        let macsRef = storageRef.child("models/electronics/Apple/Mac")
        let displaysRef = storageRef.child("models/electronics/Apple/displays")
        let iPhonesRef = storageRef.child("models/electronics/Apple/iPhone")
        
        var defaultData = Data()
        if let path = Bundle.main.path(forResource: "art.scnassets/ship", ofType: "scn") {
            do {
                defaultData = try Data(contentsOf: URL(fileURLWithPath: path))
            } catch {
                print("Error uploading file: \(error)")
            }
        } else {
            print("File not found")
        }
        
        var modelRef: StorageReference
        switch parent {
        case "Mac": modelRef = macsRef.child("\(modelName).\(format)")
        case "iPhone": modelRef = iPhonesRef.child("\(modelName).\(format)")
        case "displays": modelRef = displaysRef.child("\(modelName).\(format)")
        default: modelRef = storageRef.child("models/\(modelName).\(format)")
        }
        
        modelRef.getData(maxSize: 10000000) { data, error in
            guard error == nil else { completion(defaultData); return }
            
            if let error = error {
                print("Error downloading model: \(error)")
                completion(nil)
            } else {
                completion(data)
            }
        }
    }
    
}

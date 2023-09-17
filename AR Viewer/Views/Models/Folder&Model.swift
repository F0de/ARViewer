//
//  ModelType.swift
//  AR Viewer
//
//  Created by Влад Тимчук on 17.09.2023.
//

import Foundation
import ARKit

// ModelCell data type
class Model: Identifiable, Hashable, Equatable {
    let id = UUID()
    var name: String
    var scene: SCNNode
    
    init(name: String, scene: SCNNode) {
        self.name = name
        self.scene = scene
    }
    
    static func == (lhs: Model, rhs: Model) -> Bool {
        return lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.scene == rhs.scene
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(scene)
    }
}

// FolderCell data type
class Folder: Identifiable, Hashable, Equatable {
    let id = UUID()
    var name: String
    var internalFolder: [Folder]?
    var model: Model?
    
    init(name: String, internalFolder: [Folder]? = nil, model: Model? = nil) {
        self.name = name
        self.internalFolder = internalFolder
        self.model = model
    }
    
    static func == (lhs: Folder, rhs: Folder) -> Bool {
        return lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.internalFolder == rhs.internalFolder &&
        lhs.model == rhs.model
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(internalFolder)
        hasher.combine(model)
    }
}

#if DEBUG
extension Folder {
    static var folders = [
        Folder(name: "Games", internalFolder: [
            Folder(name: "Counter Strike 2", internalFolder: [
                //TODO: add models
            ]),
            Folder(name: "Dota 2"),
            Folder(name: "Valorant"),
            Folder(name: "World of Tanks"),
            Folder(name: "Minecraft")
        ]),
        Folder(name: "Laptops"),
        Folder(name: "Phones"),
        Folder(name: "Watch"),
        Folder(name: "Computers")
    ]
}
#endif

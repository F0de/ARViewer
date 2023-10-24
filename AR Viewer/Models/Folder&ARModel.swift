//
//  Folder&ARModel.swift
//  AR Viewer
//
//  Created by Влад Тимчук on 17.09.2023.
//

import Foundation
import RealmSwift
import FirebaseStorage

// FolderCell data type
class Folder: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    
    @Persisted var subFolders: List<Folder> = List<Folder>()
    @Persisted var models: List<ARModel> = List<ARModel>()
    
    @Persisted(originProperty: "subFolders") var folder: LinkingObjects<Folder>
    
    override class func primaryKey() -> String? {
        "id"
    }
}

// ARModelCell data type
class ARModel: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var ref: String
    
    @Persisted(originProperty: "models") var folder: LinkingObjects<Folder>
    
    override class func primaryKey() -> String? {
        "id"
    }
}

//
//  Folder.swift
//  AR Viewer
//
//  Created by Влад Тимчук on 17.09.2023.
//

import Foundation
import RealmSwift

// FolderCell data type
class Folder: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    
    @Persisted var subFolders: List<Folder> = List<Folder>()
    @Persisted var models: List<ARModel> = List<ARModel>()
    
    @Persisted(originProperty: "subFolders") var folder: LinkingObjects<Folder>
    
    override class func primaryKey() -> String? {
        "id"
    }
}

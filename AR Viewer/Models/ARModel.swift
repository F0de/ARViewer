//
//  ARModel.swift
//  AR Viewer
//
//  Created by Влад Тимчук on 25.10.2023.
//

import Foundation
import RealmSwift

// ARModelCell data type
class ARModel: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var ref: String
    
    @Persisted(originProperty: "models") var folder: LinkingObjects<Folder>
    
    override class func primaryKey() -> String? {
        "id"
    }
}

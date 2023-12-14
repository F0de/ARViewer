//
//  User.swift
//  AR Viewer
//
//  Created by Влад Тимчук on 14.12.2023.
//

import Foundation
import RealmSwift

class User: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var email: String
    
    @Persisted var models: List<ARModel> = List<ARModel>()
    
    override class func primaryKey() -> String? {
        "id"
    }
}

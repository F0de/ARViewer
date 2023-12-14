//
//  UserFIrebase.swift
//  AR Viewer
//
//  Created by Влад Тимчук on 14.12.2023.
//

import Foundation

struct UserFirebase: Identifiable, Codable {
    let id = UUID()
    let name: String
    let email: String
}

//
//  AppDelegate.swift
//  AR Viewer
//
//  Created by Влад Тимчук on 16.09.2023.
//

import UIKit
import FirebaseCore

class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        let _ = print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path)
        return true
    }

}


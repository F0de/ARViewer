//
//  TabBarView.swift
//  AR Viewer
//
//  Created by Влад Тимчук on 16.12.2023.
//

import SwiftUI

struct TabBarView: UIViewControllerRepresentable {
    typealias UIViewControllerType = TabBarController
    
    func makeUIViewController(context: Context) -> TabBarController {
        let vc = TabBarController()
        return vc
    }
    
    func updateUIViewController(_ uiViewController: TabBarController, context: Context) {
        // Updates the state of the specified view controller with new information from SwiftUI.
    }
}

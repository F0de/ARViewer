//
//  AR_ViewerApp.swift
//  AR Viewer
//
//  Created by Влад Тимчук on 16.12.2023.
//

import SwiftUI

@main
struct AR_ViewerApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    @StateObject var viewModel = AuthViewModel()

    var body: some Scene {
        WindowGroup {
            if viewModel.userSession == nil {
               TabBarView()
                    .ignoresSafeArea()
            } else {
                SignInView()
                    .environmentObject(viewModel)
            }
        }
    }
}

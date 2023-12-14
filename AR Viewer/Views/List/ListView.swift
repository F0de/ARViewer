//
//  ListView.swift
//  AR Viewer
//
//  Created by Влад Тимчук on 25.09.2023.
//

import SwiftUI
import RealmSwift

struct ListView: View {
    @ObservedRealmObject var folder: Folder
    @ObservedResults(Folder.self) var folders
    @StateObject var manager = APIManager.shared
    
    @State private var isShowingAddFolderSheet = false
    @State private var isShowingAddModelSheet = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(folder.subFolders) { folder in
                    FolderCellView(folder: folder, manager: manager)
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                $folders.remove(folder)
                            } label: {
                                Image(systemName: "trash.fill")
                            }
                        }
                }
            }
            .navigationTitle("3D Models")
            .listStyle(.plain)
            .environment(\.defaultMinListRowHeight, 70)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu("Create") {
                        Button("New Folder") {
                            isShowingAddFolderSheet.toggle()
                        }
                        Button("New Model") {
                            isShowingAddModelSheet.toggle()
                        }
                    }
                }
            }
            .sheet(isPresented: $isShowingAddModelSheet) { AddModelView(folder: folder) }
            .sheet(isPresented: $isShowingAddFolderSheet) { AddSubFolderView(folder: folder) }
        }
    }
}

//
//  ListView.swift
//  AR Viewer
//
//  Created by Влад Тимчук on 25.09.2023.
//

import SwiftUI
import RealmSwift

struct ListView: View {
    @ObservedResults(Folder.self) var folders
    @ObservedRealmObject var folder: Folder

    @State private var isShowingAddFolderSheet = false
    @State private var isShowingAddModelSheet = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(folder.subFolders) { folder in
                    FolderCellView(folder: folder)
                }.onDelete(perform: $folder.subFolders.remove)
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

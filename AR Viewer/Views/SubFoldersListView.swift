//
//  SubFoldersListView.swift
//  AR Viewer
//
//  Created by Влад Тимчук on 19.10.2023.
//

import SwiftUI
import RealmSwift

struct SubFoldersListView: View {
    @ObservedRealmObject var folder: Folder        
    @ObservedResults(Folder.self) var folders
    @ObservedObject var manager: APIManager

    @State private var isShowingAddFolderSheet = false
    @State private var isShowingAddModelSheet = false
    
    var body: some View {
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
        .listStyle(.plain)
        .environment(\.defaultMinListRowHeight, 70)
        .navigationTitle("3D Models")
        .navigationBarTitleDisplayMode(.inline)
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

//
//  FolderCellView.swift
//  AR Viewer
//
//  Created by Влад Тимчук on 19.10.2023.
//

import SwiftUI
import RealmSwift

struct FolderCellView: View {
    @ObservedRealmObject var folder: Folder
        
    var body: some View {
        NavigationLink {
            if folder.models.isEmpty {
                SubFoldersListView(folder: folder)
            } else {
                ModelsListView(folder: folder)
            }
        } label: {
            Text(folder.name)
                .font(.custom("FixelText-Medium", size: 18))
        }
    }
}

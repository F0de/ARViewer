//
//  ModelsListView.swift
//  AR Viewer
//
//  Created by Влад Тимчук on 23.10.2023.
//

import SwiftUI
import RealmSwift

struct ModelsListView: View {
    @ObservedRealmObject var folder: Folder
    @ObservedResults(ARModel.self) var models
    let manager = APIManager.shared

    @State private var isShowingAddModelSheet = false

    var body: some View {
        List(folder.models, id: \.id) { model in
            ModelCellView(model: model)
                .swipeActions(edge: .trailing) {
                    Button(role: .destructive) {
                        $models.remove(model)
                        manager.deleteModel(model)
                    } label: {
                        Image(systemName: "trash.fill")
                    }
                }
        }
        .navigationTitle("3D Models")
        .listStyle(.plain)
        .environment(\.defaultMinListRowHeight, 70)
        .navigationBarTitleDisplayMode(.inline)
        .tint(.yellow)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("New Model") {
                    isShowingAddModelSheet.toggle()
                }
            }
        }
        .sheet(isPresented: $isShowingAddModelSheet) { AddModelView(folder: folder) }    }
}

#Preview {
    ModelsListView(folder: Folder())
}

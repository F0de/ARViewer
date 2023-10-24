//
//  AddModelView.swift
//  AR Viewer
//
//  Created by Влад Тимчук on 16.10.2023.
//

import SwiftUI
import RealmSwift
import UIKit
import FirebaseStorage

struct AddModelView: View {
    @ObservedRealmObject var folder: Folder
    
    @State private var name: String = ""
    @State private var fileRef: String = ""
    @Environment(\.dismiss) var dismiss
    @State private var showFileImporter = false
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Model name", text: $name)
                    .textFieldStyle(.roundedBorder)
                Button {
                    showFileImporter.toggle()
                } label: {
                    HStack {
                        Image(systemName: "folder.badge.plus")
                        Text("Choose file")
                    }
                    .frame(maxHeight: 40)
                }
                .buttonStyle(.bordered)
                .padding(.top, 20)
                .tint(.blue)
                Button {
                    let model = ARModel()
                    model.name = name
                    model.ref = fileRef
                    
                    $folder.models.append(model)
                    
                    dismiss()
                } label: {
                    Text("Create")
                        .frame(maxWidth: .infinity, maxHeight: 40)
                }
                .buttonStyle(.borderedProminent)
                .padding(.top, 20)
                .tint(.green)
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: { dismiss() }, label: {
                        HStack {
                            Image(systemName: "chevron.backward")
                            Text("Back")
                        }
                    })
                }
            }
            .fileImporter(isPresented: $showFileImporter, allowedContentTypes: [.usdz]) { result in //TODO: add all ARKit support file types
                switch result {
                case .success(let url):
                    print("file loaded. URL: \(url)")
                    fileRef = APIManager().addModel(name, to: folder, fileURL: url)
                case .failure(let error):
                    print("Error while selecting a file: \(error)")
                }
            }
        }
    }
}

#Preview {
    AddModelView(folder: Folder())
}

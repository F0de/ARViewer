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
    let manager = APIManager.shared

    @State private var name: String = ""
    @State private var fileRef: String = ""
    @State private var fileURL: URL?
    @Environment(\.dismiss) var dismiss
    @State private var showFileImporter = false
    @State private var showingAlert = false

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
                    if let fileURL = fileURL {
                        print("Selected file: \(fileURL.lastPathComponent)")
                        fileRef = manager.addModel(name, to: folder, fileURL: fileURL)
                    } else {
                        showingAlert.toggle()
                    }
                    
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
                    print("File loaded. URL: \(url)")
                    fileURL = url
                case .failure(let error):
                    print("Error while selecting a file. Error: \(error.localizedDescription)")
                }
            }
            .alert("Error, file not loaded.", isPresented: $showingAlert) {
                Button("OK", role: .cancel) { dismiss() }
            }
        }
    }
}

#Preview {
    AddModelView(folder: Folder())
}

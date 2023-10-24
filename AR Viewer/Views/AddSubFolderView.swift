//
//  AddSubFolderView.swift
//  AR Viewer
//
//  Created by Влад Тимчук on 16.10.2023.
//

import SwiftUI
import RealmSwift

struct AddSubFolderView: View {
    @ObservedRealmObject var folder: Folder
    
    @State private var name = ""
    @Environment(\.dismiss) var dismiss
        
    var body: some View {
        NavigationView {
            VStack {
                TextField("Folder name", text: $name)
                    .textFieldStyle(.roundedBorder)
                Button {
                    let folder = Folder()
                    folder.name = name
                    
                    $folder.subFolders.append(folder)
                    
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
        }
    }
}

#Preview {
    AddSubFolderView(folder: Folder())
}

//
//  ModelCellView.swift
//  AR Viewer
//
//  Created by Влад Тимчук on 19.10.2023.
//

import SwiftUI
import RealmSwift
import ARKit

struct ModelCellView: View {
    @ObservedRealmObject var model: ARModel
    let manager = APIManager.shared

    var body: some View {
        HStack {
            Text(model.name)
                .font(.custom("FixelText-Medium", size: 18))
            Spacer()
            Button {
                // select model
                manager.getModel(model)
            } label: {
                Text("Select")
            }.buttonStyle(.borderedProminent)
        }
    }
}

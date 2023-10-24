//
//  ModelCellView.swift
//  AR Viewer
//
//  Created by Влад Тимчук on 19.10.2023.
//

import SwiftUI

struct ModelCellView: View {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    var body: some View {
        HStack {
            Text(name)
                .font(.custom("FixelText-Medium", size: 18))
            Spacer()
            Button {
                // select model
            } label: {
                Text("Select")
            }.buttonStyle(.borderedProminent)
            
        }
    }
}

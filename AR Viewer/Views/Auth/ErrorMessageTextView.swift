//
//  ErrorMessageTextView.swift
//  AR Viewer
//
//  Created by Влад Тимчук on 13.12.2023.
//

import SwiftUI

struct ErrorMessageTextView: View {
    var message: String
    
    var body: some View {
        Text(message)
            .frame(height: 20)
            .padding(.vertical, 5)
            .padding(.leading, 5)
            .font(.subheadline)
            .foregroundStyle(.red)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

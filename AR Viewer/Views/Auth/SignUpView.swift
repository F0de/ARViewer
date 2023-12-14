//
//  SignUpView.swift
//  AR Viewer
//
//  Created by Влад Тимчук on 13.12.2023.
//

import SwiftUI

struct SignUpView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var repeatPassword = ""

    @State private var isEmailValid: Bool = true
    
    private var nameErrorMessage = ""
    private var emailErrorMessage = "Email is invalid"
    private var passwordErrorMessage = ""
    private var repeatPasswordErrorMessage = ""

    @FocusState var isFocus: Bool
    
    var body: some View {
        ZStack {
            Rectangle().fill(.background)
            VStack {
                arIcon
                Spacer().frame(height: 50)
                TextField("Name", text: $name)
                    .focused($isFocus)
                ErrorMessageTextView(message: nameErrorMessage)
                TextField("Email", text: $email)
                    .focused($isFocus)
                ErrorMessageTextView(message: email.count == 0 ? "" : isEmailValid ? "" : emailErrorMessage)
                SecureField("Password", text: $password)
                    .focused($isFocus)
                ErrorMessageTextView(message: passwordErrorMessage)
                SecureField("Repeat password", text: $repeatPassword)
                    .focused($isFocus)
                ErrorMessageTextView(message: repeatPasswordErrorMessage)
                SignUpButton(name: $name, email: $email, password: $password, repeatPassword: $repeatPassword)
                Spacer()
            }
            .padding()
            .onChange(of: email) { newValue in
                isEmailValid = isValidEmail(newValue)
            }
        }.onTapGesture { isFocus = false }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}$", options: [.caseInsensitive])
        return regex.firstMatch(in: email, options: [], range: NSRange(location: 0, length: email.utf16.count)) != nil
    }
}

private var arIcon: some View {
    Image("arIcon")
        .resizable()
        .frame(width: 170, height: 170)
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .padding(.top, 50)
}

struct SignUpButton: View {
    @EnvironmentObject var vm: AuthViewModel
    
    @Binding var name: String
    @Binding var email: String
    @Binding var password: String
    @Binding var repeatPassword: String

    var body: some View {
        Button {
            Task {
                try await vm.signUp(withEmail: email, password: password, name: name)
            }
        } label: {
            Text("Create Account")
                .frame(maxWidth: .infinity)
                .frame(height: 30)
        }
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    SignUpView()
}

//
//  SignInView.swift
//  AR Viewer
//
//  Created by Влад Тимчук on 13.12.2023.
//

import SwiftUI
import FirebaseAuth

struct SignInView: View {
    @EnvironmentObject var vm: AuthViewModel
    
    @State private var email = ""
    @State private var password = ""

    @State private var isEmailValid: Bool = true
    
    private var emailErrorMessage = "Email is invalid"
    private var passwordErrorMessage = ""
    
    @State private var isShowingCreateAccountSheet = false
    @FocusState var isFocus: Bool

    var body: some View {
        NavigationView {
            ZStack {
                Rectangle().fill(.background)
                VStack {
                    Spacer().frame(height: 50)
                    arIcon
                    TextField("Email", text: $email)
                        .focused($isFocus)
                        .padding(.top, 100)
                    ErrorMessageTextView(message: email.count == 0 ? "" : isEmailValid ? "" : emailErrorMessage)
                    SecureField("Password", text: $password)
                        .focused($isFocus)
                    ErrorMessageTextView(message: passwordErrorMessage)
                    SignInButton(email: $email, password: $password)
                    Spacer()
                    CreateAccountButton(isShowingCreateAccountSheet: $isShowingCreateAccountSheet)
                }
                .padding()
                .sheet(isPresented: $isShowingCreateAccountSheet) { SignUpView() }
                .onChange(of: email) { newValue in
                    isEmailValid = isValidEmail(newValue)
                }
            }.onTapGesture { isFocus = false }
        }
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
}

struct SignInButton: View {
    @EnvironmentObject var vm: AuthViewModel
    
    @Binding var email: String
    @Binding var password: String

    var body: some View {
        Button {
            Task {
                try await vm.signIn(withEmail: email, password: password)
            }
        } label: {
            Text("Sign In")
                .frame(maxWidth: .infinity)
                .frame(height: 30)
        }
        .buttonStyle(.borderedProminent)
    }
}

struct CreateAccountButton: View {
    @Binding var isShowingCreateAccountSheet: Bool
    
    var body: some View {
        Button {
            isShowingCreateAccountSheet.toggle()
        } label: {
            HStack {
                Text("Dont have an account?")
                Text("Sign Up")
                    .bold()
            }
        }
    }
}

#Preview {
    SignInView()
}

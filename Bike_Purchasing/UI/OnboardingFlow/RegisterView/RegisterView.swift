//
//  ContentView.swift
//  RegesterScreen
//
//  Created by Guru  Mahan on 25/01/26.
//

import SwiftUI
import _SwiftData_SwiftUI


struct RegisterView: View {
    @StateObject var viewModel: RegisterVM = RegisterVM()
    
    @EnvironmentObject var router: NavigationRouter
    @Environment(\.modelContext) private var context
    @Query var users: [User]
    
    var body: some View {
        GeometryReader { geo in
         
            VStack(spacing: 20){
                Text("Register")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                textField(placeHolder: "UserName", $viewModel.username)
                VStack(alignment: .leading) {
                    textField(placeHolder: "Email", $viewModel.emailText)
                    if !viewModel.emailErrorMessage.isEmpty {
                        errorHandlingView(errorText: viewModel.emailErrorMessage)
                    }
                }
                
                VStack(alignment: .leading) {
                    passwordTextField(
                        placeHolder: "New Password", $viewModel.newPasswordText,
                        icon: "lock",
                        isSecure: true,
                        showToggle: $viewModel.showPassword
                    )
                    
                    passwordTextField(
                        placeHolder: "Confirm Password",
                        $viewModel.confirmPasswordText,
                        icon: "lock.fill",
                        isSecure: true,
                        showToggle: $viewModel.showConfirmPassword
                       )
                    
                    if  viewModel.showPasswordMustBeSameError {
                        errorHandlingView(errorText: "New and Confirm Password Must be Same")
                    }
                }
                
                buttonActionView
                                
            }
            .padding(.vertical, 12)
            .background(
                Color.white
                    .cornerRadius(12)
            )
            .padding(.horizontal, 16)
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(AppBackGroundView(isShowWhiteBG: false))
        }
    }

    @ViewBuilder
    func textField(placeHolder: String, _ value: Binding<String>) -> some View {
        VStack(alignment: .leading) {
            Text(placeHolder)
                .font(.system(size: 14, weight: .semibold))
            TextField(placeHolder, text: value)
                .textFieldStyle(.plain)
                .autocorrectionDisabled()
                .padding()
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
        }
        .padding(.horizontal, 16)
    }
}

extension RegisterView {
    @ViewBuilder
    func passwordTextField(
        placeHolder: String,
        _ value: Binding<String>,
        icon: String? = nil,
        isSecure: Bool = false,
        showToggle: Binding<Bool>? = nil
    ) -> some View{
        VStack(alignment: .leading) {
            Text(placeHolder)
                .font(.system(size: 14, weight: .semibold))
            HStack {
                if isSecure && !(showToggle?.wrappedValue == true) {
                    SecureField(placeHolder, text: value)
                        .textContentType(.newPassword)
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
                } else {
                    TextField(placeHolder, text: value)
                        .textContentType(.newPassword)
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
                }
                if let showToggle = showToggle {
                    Button {
                        showToggle.wrappedValue.toggle()
                    } label: {
                        Image(systemName: showToggle.wrappedValue ? "eye" : "eye.slash")
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding()
            .background(Color.black.opacity(0.05))
            .cornerRadius(10)
        }
        .padding(.horizontal, 16)
    }
    
    func errorHandlingView(errorText: String = "") -> some View {
        Text(errorText)
            .font(.system(size: 12, weight: .medium))
            .foregroundColor(Color.red.opacity(0.6))
            .padding(.horizontal, 16)
    }
}

extension RegisterView {
    var buttonActionView: some View {
        VStack(spacing: 24) {
            Button {
                
              
                if viewModel.emailText.isEmpty {
                    viewModel.emailErrorMessage = "Please Enter Email"
                } else if !viewModel.isValidEmail(viewModel.emailText) {
                    viewModel.emailErrorMessage = "Please enter valid email"
                } else if users.contains(where: {
                    $0.email.lowercased() == viewModel.emailText.lowercased()
                }) {
                    viewModel.emailErrorMessage = "Email already exists"
                } else if viewModel.newPasswordText != viewModel.confirmPasswordText {
                    viewModel.showPasswordMustBeSameError = true
                } else {
                    viewModel.emailErrorMessage = ""
                    viewModel.registerUser(modelContext: context) { status in
                        router.path.removeLast()
                    }
                }
            } label: {
                Text("Register")
                    .foregroundColor(.white)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 10)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
           
            VStack(spacing: 5) {
                Text("already you have a login?")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(Color.gray)
                Button {
                    router.path.removeLast()
                } label: {
                    Text("Login")
                        .foregroundColor(Color.blue)
                        .font(.system(size: 16, weight:
                                .semibold))
                        .padding(.horizontal, 50)
                }
           }
        }
    }
}

#Preview {
    RegisterView()
}

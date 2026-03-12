//
//  LoginView.swift
//  Bike_Purchasing
//
//  Created by Guru  Mahan on 25/01/26.
//

import SwiftUI
import SwiftData

enum AppRoute: Hashable {
    case login
    case home(email: String)
    case bikeDetails(_ bikeDetails: BikeModel)
    case register
    case cart
    case profile
    case orderPlacedAnimated
}

struct LoginView: View {
    @StateObject var viewModel: LoginVM = LoginVM()
    
    @EnvironmentObject var router: NavigationRouter
    @Query private var users: [User]
    
    var body: some View {
        ZStack {
            AppBackGroundView()
            VStack(spacing: 20){
                Text("login")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                textField(placeHolder: "Email", $viewModel.emailText, error: viewModel.emailError) { error in
                    viewModel.emailError = ""
                }
                passwordTextField(
                    placeHolder: "Password", $viewModel.password,
                    icon: "lock",
                    isSecure: true,
                    showToggle: $viewModel.showPassword,
                    error: viewModel.passwordError
                )
                
                
//                textField(placeHolder: "Password", $viewModel.password, error: viewModel.passwordError) { error in
//                    viewModel.password = ""
//                }
                
                buttonActionView
            }
        }
        .navigationBarHidden(true)
        .alert("Error", isPresented: $viewModel.showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(viewModel.alertError)
        }
    }
    
    @ViewBuilder
    func textField(placeHolder: String, _ value: Binding<String>, error: String, completion: @escaping ((String) -> Void)) -> some View {
        VStack(alignment: .leading) {
            Text(placeHolder)
                .font(.system(size: 14, weight: .semibold))
            TextField(placeHolder, text: value)
                .padding()
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
                .onChange(of: value.wrappedValue) { newValue in
                    completion("")
                }
            if !error.isEmpty {
                Text(error)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.red.opacity(0.7))
            }
        }
        .padding(.horizontal, 16)
    }
}

extension LoginView {
    @ViewBuilder
    func passwordTextField(
        placeHolder: String,
        _ value: Binding<String>,
        icon: String? = nil,
        isSecure: Bool = false,
        showToggle: Binding<Bool>? = nil,
        error: String
    ) -> some View {
        VStack(alignment: .leading) {
            Text(placeHolder)
                .font(.system(size: 14, weight: .semibold))
            HStack {
                if isSecure && !(showToggle?.wrappedValue == true) {
                    SecureField(placeHolder, text: value)
                        .textContentType(.newPassword)
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
                        .onChange(of: viewModel.password) {
                            viewModel.passwordError = ""
                        }
                } else {
                    TextField(placeHolder, text: value)
                        .textContentType(.newPassword)
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
                        .onChange(of: viewModel.password) {
                            viewModel.passwordError = ""
                        }
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
            if !error.isEmpty {
                Text(error)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.red.opacity(0.7))
            }
        }
        .padding(.horizontal, 16)
    }
}

extension LoginView {
    var buttonActionView: some View {
        VStack {
            Button {
                viewModel.showingRegister = true
                viewModel.loginUser(users) { email in
                    router.path = [.home(email: email)]
                }
            } label: {
                Text("Login")
                    .foregroundColor(.white)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 10)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            Text("Or")
            
            Button {
                router.path.append(AppRoute.register)
            } label: {
                Text("Register")
                    .foregroundColor(Color.black)
                    .font(.system(size: 16, weight: .semibold))
                    .frame(maxWidth: .infinity)
                   
                    .padding(.vertical, 10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding(.horizontal, 50)
            }
        }
    }
}

#Preview {
    LoginView()
}
    

struct AppBackGroundView: View {
    var isShowWhiteBG: Bool = true
    
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            Circle()
                .scale(1.7)
                .foregroundColor(.white.opacity(0.15))
            if isShowWhiteBG {
                Circle()
                    .scale(1.35)
                    .foregroundColor(.white)
            }
        }
    }
}

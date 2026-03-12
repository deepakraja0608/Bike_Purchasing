//
//  LoginVM.swift
//  Bike_Purchasing
//
//  Created by Guru  Mahan on 26/01/26.
//

import Foundation
import SwiftUI

class LoginVM: ObservableObject {
    @Published var username = ""
    @Published var emailText = ""
    @Published var password = ""
    @Published var newPasswordText = ""
    @Published var confirmPasswordText = ""
    @Published var wrongusername = 0
    @Published var wrongemail = 0
    @Published var wrongpassword = 0
    @Published var showingRegister = false
    @Published var showPassword = false
    @Published var showAlert = false
    @Published var alertError: String = ""
    
    @Published var emailError: String = ""
    @Published var passwordError: String = ""
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func loginUser(_ users: [User], success: ((String) -> Void)) {
        if emailText.isEmpty {
            emailError = "Please enter email"
            return
        } else if !isValidEmail(emailText) {
            emailError = "Please enter valid email"
            return
        }
     
     
        for user in users {
            print("users=--->", user.email, emailText)
        }
        if !users.contains(where: {
            $0.email.caseInsensitiveCompare(emailText) == .orderedSame
        }) {
            alertError = "Email doesn't exists, Please register your email"
            showAlert = true
            return
        }
        
        if password.isEmpty {
            passwordError = "Please enter password"
            return
        }
        
        if !users.contains(where: {
            $0.password.caseInsensitiveCompare(password) == .orderedSame
        }) {
            passwordError = "Incorrect Password"
            return
        }
        if let user = users.first(where: {
            $0.email.lowercased() == emailText.lowercased() && $0.password == password
        }) {
            success(user.email.lowercased())
            UserDefaults.standard.set(true, forKey: "login_success")
            UserDefaults.standard.set(user.email.lowercased(), forKey: "email")
            print("Login Success:", user.username)
        } else {
            print("Invalid credentials")
        }
    }
}

final class NavigationRouter: ObservableObject {
    @Published var path: [AppRoute] = []
}

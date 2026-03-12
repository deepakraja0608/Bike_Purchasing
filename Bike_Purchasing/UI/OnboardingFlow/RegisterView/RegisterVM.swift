//
//  RegisterVM.swift
//  Bike_Purchasing
//
//  Created by Guru  Mahan on 02/02/26.
//

import Foundation
import SwiftData
import SwiftUI

class RegisterVM: ObservableObject {
    @Published var username = ""
    @Published var emailText = ""
    @Published var newPasswordText = ""
    @Published var confirmPasswordText = ""
    @Published var registrationSuccess = false
    @Published var errorMessage: String?
    @Published var emailErrorMessage: String = ""
    @Published var showPassword = false
    @Published var showPasswordMustBeSameError = false
    @Published var showConfirmPassword = false
  
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    
    func registerUser(modelContext: ModelContext, completion: @escaping ((Bool) -> Void)) {
        let newUser = User(
            username: username,
            email: emailText.lowercased(),
            password: confirmPasswordText
        )

        modelContext.insert(newUser)

        do {
            try modelContext.save()
            completion(true)
        } catch {
            completion(false)
            print("Save failed:", error)
        }
    }
}

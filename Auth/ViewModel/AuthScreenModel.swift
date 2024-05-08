//
//  AuthScreenModel.swift
//  WhatsApp
//
//  Created by Fawaz Tarar on 07/05/2024.
//

import Foundation


@MainActor
final class AuthScreenModel: ObservableObject {

    @Published var isLoading = false
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var username: String = ""
    @Published var errorState: (showError: Bool, errorMessage: String) = (false, "uh oh! something went wrong")
    
   // Computed Properties
   var disableLoginButton : Bool {
       return email.isEmpty || password.isEmpty || isLoading
    }

    var disableSignUpButton : Bool {
       return email.isEmpty || password.isEmpty || username.isEmpty || isLoading
    }

    func handleSignUp() async {
        isLoading = true
        do {
            try await AuthManager.shared.createAccount(for: username, with: email, and: password)
            
        } catch {
            
            errorState.errorMessage = "Failed to create an account \(error.localizedDescription)"
            errorState.showError = true
            isLoading = false
            
        }
    }

    func handleLogin() async {
        isLoading = true
        do {
            try await AuthManager.shared.login(with: email, and: password)
            
        } catch {
            
            errorState.errorMessage = "Failed to login \(error.localizedDescription)"
            errorState.showError = true
            isLoading = false
            
        }
    }   
}


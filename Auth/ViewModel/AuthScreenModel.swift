//
//  AuthScreenModel.swift
//  WhatsApp
//
//  Created by Fawaz Tarar on 07/05/2024.
//

import Foundation

final class AuthScreenModel: ObservableObject {

    @Published var isloading = false  
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var username: String = ""
    
   // Computed Properties
   var disableLoginButton : Bool {
       return email.isEmpty || password.isEmpty || isloading
    }

    var disableSignUpButton : Bool {
       return email.isEmpty || password.isEmpty || username.isEmpty || isloading
    }
}

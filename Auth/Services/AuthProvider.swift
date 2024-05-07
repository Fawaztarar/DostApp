//
//  AuthProvider.swift
//  WhatsApp
//
//  Created by Fawaz Tarar on 07/05/2024.
//


import Foundation
import Combine
import FirebaseAuth
import FirebaseDatabase

enum AuthState {
    case pending, loggedIn, loggedOut
}

protocol AuthProvider {
    static var shared: AuthProvider { get }
    var authState: CurrentValueSubject<AuthState, Never> { get }

    func autoLogin() async
    func login(with email: String, and password: String) async throws
    func createAccount(for username: String, with email: String, and password: String) async throws
    func signOut() async throws
}

final class AuthManager: AuthProvider {
    
    private init() {
        
    }

    static let shared: AuthProvider = AuthManager()
     
    var authState = CurrentValueSubject<AuthState, Never>(.pending)

    

    func autoLogin() async {
        // Implement auto-login logic here
    }

    func login(with email: String, and password: String) async throws {
        // Implement login logic here
    }

    func createAccount(for username: String, with email: String, and password: String) async throws {
        // Invoke Firebase auth and store user in database
        let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
        let uid = authResult.user.uid
        let newUser = UserItem(uid: uid, username: username, email: email, password: password)
        try await saveUserToDatabase(user: newUser)
    }

    func signOut() async throws {
        // Implement sign-out logic here
    }

    private func saveUserToDatabase(user: UserItem) async throws {
        let userDictionary = ["uid": user.uid, "username": user.username, "email": user.email, "password": user.password]
        try await Database.database().reference().child("users").child(user.uid).setValue(userDictionary)
    }
}

struct UserItem: Identifiable, Hashable, Decodable {
    let uid: String
    let username: String
    let email: String
    let password: String
    var bio: String? = nil
    var profileImageUrl: String? = nil

    var id: String {
        return uid
    }

    var bioUnwrapped: String {
        return bio ?? "Hey there! I am using WhatsApp"
    }
}

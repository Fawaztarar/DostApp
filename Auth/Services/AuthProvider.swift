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
    case pending, loggedIn(UserItem), loggedOut
}

protocol AuthProvider {
    static var shared: AuthProvider { get }
    var authState: CurrentValueSubject<AuthState, Never> { get }

    func autoLogin() async
    func login(with email: String, and password: String) async throws
    func createAccount(for username: String, with email: String, and password: String) async throws
    func logOut() async throws
}

enum AuthError: Error {
    case accountCreationFailed(_ description: String)
    case failedtosaveUserToDatabase(_ description: String)
    case emailloginFailed(_ description: String)
}

extension AuthError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .accountCreationFailed(let description):
            return description
        case .failedtosaveUserToDatabase(let description):
            return description

        case .emailloginFailed(let description):
            return description
        }
    }
}

final class AuthManager: AuthProvider {
    
    private init() {
        Task {
            await autoLogin()
        } 
    }

    static let shared: AuthProvider = AuthManager()
     
    var authState = CurrentValueSubject<AuthState, Never>(.pending)

    

    func autoLogin() async {
        if Auth.auth().currentUser == nil {
            authState.send(.loggedOut)
        } else {
             fetchCurrentUserInfo()
        }
    }


    func login(with email: String, and password: String) async throws {
        do {
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
            fetchCurrentUserInfo()
            print("🔐 Successfully logged in: \(authResult.user.email ?? "")")
        } catch {
            print("🔐 Failed to login with email: \(email)")
            throw AuthError.emailloginFailed(error.localizedDescription)
        }
    }

    func createAccount(for username: String, with email: String, and password: String) async throws {
        do {
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
        let uid = authResult.user.uid
        let newUser = UserItem(uid: uid, username: username, email: email, password: password)
        try await saveUserToDatabase(user: newUser)
        self.authState.send(.loggedIn(newUser))
        } catch {
            print("🔐 Failed to create an account: \(error.localizedDescription)")
            throw AuthError.accountCreationFailed(error.localizedDescription) 
        }
        
    }

    func logOut() async throws {
        do {
            try Auth.auth().signOut()
            authState.send(.loggedOut)
            print("🔐 Successfully logged out")
        } catch {
            print("🔐 Failed to log out: \(error.localizedDescription)")
        }
    
        
    }

    private func saveUserToDatabase(user: UserItem) async throws {
        do {
            let userDictionary: [String: Any] = [.uid : user.uid, .username : user.username, .email : user.email, .password : user.password]
            try await FirebaseConstants.UserRef.child(user.uid).setValue(userDictionary)
        } catch {
            print("🔐 Failed to save user to database:  \(error.localizedDescription)")
            throw AuthError.failedtosaveUserToDatabase(error.localizedDescription)
        }
    }

    private func fetchCurrentUserInfo() {
        // Implement fetch user from database logic here
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        FirebaseConstants.UserRef.child(currentUid).observe(.value) {[weak self] snapshot in
            
            guard let userDict = snapshot.value as? [String: Any] else { return }
            let loggedInUser = UserItem(dictionary: userDict)
            self?.authState.send(.loggedIn(loggedInUser))
            print("🔐 \(loggedInUser.username) is logged in")

        } withCancel: { error in
            print("🔐 Failed to fetch user from database: \(error.localizedDescription)")
        }
    }
}

extension AuthManager {
    static let testAccounts: [String ] = [
    "x1@test.com",
    "x2@test.com",
    "x3@test.com",
    "x4@test.com",
    "x5@test.com",
    "x6@test.com",
    "x7@test.com",
    "x8@test.com",
    "x9@test.com",
    "x10@test.com",
    "x11@test.com",
    "x12@test.com",
    "x13@test.com",
    "x14@test.com",
    "x15@test.com",
    "x16@test.com",
    "x17@test.com",
    "x18@test.com",
    "x19@test.com",
    "x20@test.com",
    "x21@test.com",
    "x23@test.com",
    "x24@test.com",
    "x25@test.com",
    "x26@test.com",
    "x27@test.com",
    "x28@test.com",
    "x29@test.com",
    "x30@test.com",


    ]
}
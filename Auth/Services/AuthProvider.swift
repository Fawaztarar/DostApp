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
    func signOut() async throws
}

enum AuthError: Error {
    case accountCreationFailed(_ description: String)
    case failedtosaveUserToDatabase(_ description: String)
}

extension AuthError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .accountCreationFailed(let description):
            return description
        case .failedtosaveUserToDatabase(let description):
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
            await fetchCurrentUserInfo()
        }
    }


    func login(with email: String, and password: String) async throws {
        // Implement login logic here
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

    func signOut() async throws {
        // Implement sign-out logic here
    }

    private func saveUserToDatabase(user: UserItem) async throws {
        do {
            let userDictionary = ["uid": user.uid, "username": user.username, "email": user.email, "password": user.password]
            try await Database.database().reference().child("users").child(user.uid).setValue(userDictionary)
        } catch {
            print("🔐 Failed to save user to database:  \(error.localizedDescription)")
            throw AuthError.failedtosaveUserToDatabase(error.localizedDescription)
        }
    }

    private func fetchCurrentUserInfo() async {
        // Implement fetch user from database logic here
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        Database.database().reference().child("users").child(currentUid).observe(.value) {[weak self] snapshot in
            
            guard let userDict = snapshot.value as? [String: Any] else { return }
            let loggedInUser = UserItem(dictionary: userDict)
            self?.authState.send(.loggedIn(loggedInUser))
            print("🔐 \(loggedInUser.username) is logged in")

        } withCancel: { error in
            print("🔐 Failed to fetch user from database: \(error.localizedDescription)")
        }
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

extension UserItem {
    init(dictionary: [String: Any]) {
        self.uid = dictionary["uid"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.password = dictionary["password"] as? String ?? ""
        self.bio = dictionary["bio"] as? String ?? nil
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? nil 
    }
}

extension String {
    static let uid = "uid"
    static let username = "username"
    static let email = "email"
    static let password = "password"
    static let bio = "bio"
    static let profileImageUrl = "profileImageUrl"
}

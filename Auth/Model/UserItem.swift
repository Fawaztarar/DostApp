//
//  UserItem.swift
//  WhatsApp
//
//  Created by Fawaz Tarar on 07/05/2024.
//

import Foundation

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
    
    static let placeholder = UserItem(uid: "1", username: "Fawaz", email: "fawaz@gmail.com", password: "12345678")
    
    static let placeholders: [UserItem] = [
        UserItem(uid: "1", username: "X1", email: "x1@gmail.com", password: "12345678", bio: "Positive vibes only!"),
        UserItem(uid: "2", username: "X2", email: "x2@gmail.com", password: "12345678", bio: "Nice Human!"),
        UserItem(uid: "3", username: "X3", email: "x3@gmail.com", password: "12345678", bio: "Talk to me!"),
        UserItem(uid: "4", username: "X4", email: "x4@gmail.com", password: "12345678", bio: "away"),
        UserItem(uid: "5", username: "X5", email: "x5@gmail.com", password: "12345678", bio: "Hey there! I am using WhatsApp"),
        UserItem(uid: "6", username: "X6", email: "x6@gmail.com", password: "12345678", bio: "Hey there! I am using WhatsApp"),
        UserItem(uid: "7", username: "X7", email: "x7@gmail.com", password: "12345678", bio: "Busy right now!"),
        UserItem(uid: "8", username: "X8", email: "x8@gmail.com", password: "12345678", bio: "Hey there! I am using WhatsApp"),
        UserItem(uid: "9", username: "X9", email: "x9@gmail.com", password: "12345678", bio: "Hey there! I am using WhatsApp"),
        
    ]
    
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

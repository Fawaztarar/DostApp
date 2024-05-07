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

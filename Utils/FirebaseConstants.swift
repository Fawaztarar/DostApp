//
//  FirebaseConstants.swift
//  WhatsApp
//
//  Created by Fawaz Tarar on 07/05/2024.
//

import Foundation
import Firebase


enum FirebaseConstants {
    private static let DatabaseRef =    Database.database().reference()
    static let UserRef = DatabaseRef.child("users")
}

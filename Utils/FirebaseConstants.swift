//
//  FirebaseConstants.swift
//  WhatsApp
//
//  Created by Fawaz Tarar on 07/05/2024.
//

import Foundation
import Firebase
import FirebaseDatabase


enum FirebaseConstants {
    private static let DatabaseRef =    Database.database().reference()
    static let UserRef = DatabaseRef.child("users")
    static let ChannelsRef = DatabaseRef.child("channels")
    static let MessagesRef = DatabaseRef.child("channel-messages")
    static let UserChannelRef = DatabaseRef.child("user-channels")
    static let UserDirectChannels = DatabaseRef.child("user-direct-channels")
}

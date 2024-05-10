//
//  ChannelItem.swift
//  WhatsApp
//
//  Created by Fawaz Tarar on 10/05/2024.
//

import Foundation

struct ChannelItem: Identifiable {
    var id: String
    var name: String?
    var lastMessage: String
    var creationDate: Date
    var lastMessageTimeStamp: Date
    var membersCount: UInt
    var adminUids: [String]
    var membersUids: [String]
    var members: [UserItem]
    var thumbnailUrl: String?
    
    // Computed property to determine if it's a group chat
    var isGroupChat: Bool {
        return membersCount > 2
    }
    
    static let placeholder = ChannelItem.init(id: "1", lastMessage: "Hello", creationDate: Date(), lastMessageTimeStamp: Date(), membersCount: 2, adminUids: [], membersUids: [], members: [] )
}


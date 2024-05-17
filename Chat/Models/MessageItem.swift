 //
//  MessageItem.swift
//  WhatsApp
//
//  Created by Fawaz Tarar on 02/05/2024.
//

import Foundation
import SwiftUI  
import Firebase

struct MessageItem: Identifiable {
    let id: String
    let text: String
    let type: MessageType
    let ownerUid: String
    let timeStamp: Date

    var direction: MessageDirection{
        return ownerUid == Auth.auth().currentUser?.uid ? .sent : .received
    }
    
    static let sentPlaceholder = MessageItem(id: UUID().uuidString, text: "Holy Spaghetti", type: .text, ownerUid: "1", timeStamp: Date())
    static let receivedPlaceholder = MessageItem(id: UUID().uuidString, text: "Hey Dude what's up", type: .text, ownerUid: "2", timeStamp: Date())


    var alignment: Alignment {
        return direction == .received ? .leading : .trailing
    }

    var horizontalAlignment: HorizontalAlignment {
        return direction == .received ? .leading : .trailing
    }

    var backgroundColor: Color {
        return direction == .sent ? .bubbleGreen : .bubbleWhite
    }
    static let stubMessages: [MessageItem] = [
        MessageItem(id: UUID().uuidString, text: "Hello", type: .text, ownerUid: "3", timeStamp: Date()),
        MessageItem(id: UUID().uuidString, text: "Checkout this Photo", type: .photo, ownerUid: "4", timeStamp: Date()),
        MessageItem(id: UUID().uuidString, text: "Play this Video", type: .video, ownerUid: "5", timeStamp: Date()),
        MessageItem(id: UUID().uuidString, text: "Listen to this Audio", type: .audio, ownerUid: "6", timeStamp: Date())
    ]
}

extension MessageItem {
    init(id: String, dict: [String: Any]) {
        self.id = id
        self.text = dict[.text] as? String ?? ""
        let type = dict[.type] as? String ?? "text"
        self.type = MessageType(type) ?? .text
        self.ownerUid = dict[.ownerUid] as? String ?? ""
        let timeInterval = dict[.timeStamp] as? TimeInterval ?? 0
        self.timeStamp = Date(timeIntervalSince1970: timeInterval)

    }
}


extension String {
    static let type = "type"
    static let timeStamp = "timeStamp"
    static let ownerUid = "ownerUid"
    static let text = "text"

    
}

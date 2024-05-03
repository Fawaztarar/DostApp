 //
//  MessageItem.swift
//  WhatsApp
//
//  Created by Fawaz Tarar on 02/05/2024.
//

import Foundation
import SwiftUI  

struct MessageItem: Identifiable {
    let id = UUID().uuidString
    let text: String
    let type: MessageType
    let direction: MessageDirection
    
    static let sentplaceholder = MessageItem(text: "Thats Cool", type: .text, direction: .sent)
    static let receivedplaceholder = MessageItem(text: "Hey Whats up", type: .text, direction: .received)

    var alignment: Alignment {
        return direction == .received ? .leading : .trailing
    }

    var HorizontalAlignment: HorizontalAlignment {
        return direction == .received ? .leading : .trailing
    }

    var backgroundColor: Color {
        return direction == .sent ? .bubbleGreen : .bubbleWhite
    }
    static let stubMessages: [MessageItem] = [
        MessageItem(text: "Hello", type: .text, direction: .sent),
        MessageItem(text: "Checkout thus Photo", type: .photo, direction: .received),
        MessageItem(text: "Play this Video", type: .video, direction: .sent),
    ]
}
    enum MessageType {
        case text, photo, video
    }

enum MessageDirection {
    case sent, received

    static var random: MessageDirection {
        return [MessageDirection.sent, .received].randomElement() ?? .sent
    }
}

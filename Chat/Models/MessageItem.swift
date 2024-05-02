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
    let direction: MessageDirection
    
    static let sentplaceholder = MessageItem(text: "Thats Cool", direction: .sent) 
    static let receivedplaceholder = MessageItem(text: "Hey Whats up", direction: .received)

    var alignment: Alignment {
        return direction == .received ? .leading : .trailing
    }

    var HorizontalAlignment: HorizontalAlignment {
        return direction == .received ? .leading : .trailing
    }

    var backgroundColor: Color {
        return direction == .sent ? .bubbleGreen : .bubbleWhite
    }
}

enum MessageDirection {
    case sent, received

    static var random: MessageDirection {
        return [MessageDirection.sent, .received].randomElement() ?? .sent
    }
}

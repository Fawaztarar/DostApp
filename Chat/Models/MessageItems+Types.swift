//
//  MessageItems+Types.swift
//  WhatsApp
//
//  Created by Fawaz Tarar on 11/05/2024.
//

import Foundation

enum AdminMessageType: String {
    case channelCreation
    case memberAdded
    case memberLeft
    case channelNameChanged
}

    enum MessageType {
        case text, photo, video, audio

        var title: String {
            switch self {
            case .text:
                return "Text"
            case .photo:
                return "Photo"
            case .video:
                return "Video"
            case .audio:
                return "Audio"
            }
        } 
    }

enum MessageDirection {
    case sent, received

    static var random: MessageDirection {
        return [MessageDirection.sent, .received].randomElement() ?? .sent
    }
}
////
////  MessageService.swift
////  WhatsApp
////
////  Created by Fawaz Tarar on 15/05/2024.


import Foundation
import Firebase
// handle sending, fetching messages and setting reactions
struct MessageService {
    
    static func sendTextMessage(to channel: ChannelItem, from currentUser: UserItem, _ textMessage: String,  onComplete:() -> Void) {
        let timeStamp = Date().timeIntervalSince1970
        guard let messageId = FirebaseConstants.MessagesRef.child(channel.id).childByAutoId().key else { return }
        
        let channelDict: [String: Any] = [
            .lastMessage: textMessage,
            .lastMessageTimeStamp: timeStamp,
        ]
        
        let messageDict: [String: Any] = [
            .text: textMessage,
            .type: MessageType.text.title,
            .timeStamp: timeStamp,
            .ownerUid: currentUser.uid
        ]
        
        FirebaseConstants.ChannelsRef.child(channel.id).updateChildValues(channelDict)
        FirebaseConstants.MessagesRef.child(channel.id).child(messageId).setValue(messageDict)
        
        onComplete()
    }
    
    static func sendMediaMessage(to channel: ChannelItem, params: MessageUploadParams, completion: @escaping () -> Void) {
        guard let messageId = FirebaseConstants.MessagesRef.childByAutoId().key else { return }
        
        let timeStamp = Date().timeIntervalSince1970
        let channelDict: [String: Any] = [
            .lastMessage: params.text,
            .lastMessageTimeStamp: timeStamp,
            .lastMessageType: params.type.title
        ]
        
        var messageDict: [String: Any] = [
            .text: params.text,
            .type: params.type.title,
            .timeStamp: timeStamp,
            .ownerUid: params.ownerUID,
        ]
        
        /// Photo Messages
        messageDict[.thumbnailUrl] = params.thumbnailURL ?? nil
        messageDict[.thumbnailWidth] = params.thumbnailWidth ?? nil
        messageDict[.thumbnailHeight] = params.thumbnailHeight ?? nil
        
        // Assuming you have methods to update the channel and message data in Firebase
        FirebaseConstants.ChannelsRef.child(channel.id).updateChildValues(channelDict)
        FirebaseConstants.MessagesRef.child(channel.id).child(messageId).setValue(messageDict)
        completion()
        
    }
    
//    static func getMessages(for channel: ChannelItem, completion: @escaping ([MessageItem]) -> Void) {
//        FirebaseConstants.MessagesRef.child(channel.id).observe(.value) { snapshot in
//            var messages: [MessageItem] = []
//            for child in snapshot.children {
//                if let childSnapshot = child as? DataSnapshot,
//                   let messageDict = childSnapshot.value as? [String: Any] {
//                    print("Fetched message data: \(messageDict)") // Log the raw data
//                    let message = MessageItem(id: childSnapshot.key, isGroupChat: channel.isGroupChat, dict: messageDict)
//                    messages.append(message)
//                    print("Initialized MessageItem: \(message)") // Log the initialized MessageItem
//                }
//            }
//            messages.sort { $0.timeStamp < $1.timeStamp }
//            completion(messages)
//        } withCancel: { error in
//            print("Failed to get messages for \(channel.title): \(error)")
//        }
//    }
//}


    static func getMessages(for channel: ChannelItem, completion: @escaping ([MessageItem]) -> Void) {
        FirebaseConstants.MessagesRef.child(channel.id).observe(.value) { snapshot in            
            guard let dict = snapshot.value as? [String: Any] else { return }
            var messages: [MessageItem] = []
            dict.forEach { key, value in
                let messageDict = value as? [String: Any] ?? [:]
                print("Fetched message data: \(messageDict)")
                let message = MessageItem(id: key, isGroupChat: channel.isGroupChat, dict: messageDict)
                messages.append(message)
                if messages.count == snapshot.childrenCount {
                    messages.sort { $0.timeStamp < $1.timeStamp }
                    completion(messages)
                }
               
            }
            
        } withCancel: { error in
            print("failed to get messages: \(channel.title)")
     
        }
    }
    
}

struct MessageUploadParams {
    let channel: ChannelItem
    let text: String
    let type: MessageType
    let attachment: MediaAttachment
    var thumbnailURL: String?
    var videoURL: String?
    var sender: UserItem
    var audioURL: String?
    var audioDuration: TimeInterval?
    
    var ownerUID: String {
        return sender.uid
    }

    var thumbnailWidth: CGFloat? {
        guard type == .photo || type == .video else { return nil }
        return attachment.thumbnail.size.width
    }

    var thumbnailHeight: CGFloat? {
        guard type == .photo || type == .video else { return nil }
        return attachment.thumbnail.size.height
    }

}







//import Foundation
//import Firebase
//
//// handle sending, fetching messages, and setting reactions
//
//struct MessageService {
//    static func sendTextMessage(to channel: ChannelItem, from currentUser: UserItem, _ textMessage: String, onComplete: @escaping () -> Void) {
//        let timeStamp = Date().timeIntervalSince1970
//        guard let messageId = FirebaseConstants.MessagesRef.child(channel.id).childByAutoId().key else { return }
//
//        let channelDict: [String: Any] = [
//            "lastMessage": textMessage,
//            "lastMessageTimeStamp": timeStamp,
//        ]
//
//        let messageDict: [String: Any] = [
//            "text": textMessage,
//            "type": MessageType.text.title,
//            "timeStamp": timeStamp,
//            "ownerUid": currentUser.uid
//        ]
//
//        FirebaseConstants.ChannelsRef.child(channel.id).updateChildValues(channelDict) { error, _ in
//            if let error = error {
//                print("Failed to update channel: \(error)")
//                return
//            }
//            FirebaseConstants.MessagesRef.child(channel.id).child(messageId).setValue(messageDict) { error, _ in
//                if let error = error {
//                    print("Failed to send message: \(error)")
//                    return
//                }
//                onComplete()
//            }
//        }
//    }
//
//    static func sendMediaMessage(to channel: ChannelItem, params: MessageUploadParams, completion: @escaping () -> Void) {
//        guard let messageId = FirebaseConstants.MessagesRef.child(channel.id).childByAutoId().key else { return }
//
//        let timeStamp = Date().timeIntervalSince1970
//        let channelDict: [String: Any] = [
//            "lastMessage": params.text,
//            "lastMessageTimeStamp": timeStamp,
//            "lastMessageType": params.type.title
//        ]
//
//        var messageDict: [String: Any] = [
//            "text": params.text,
//            "type": params.type.title,
//            "timeStamp": timeStamp,
//            "ownerUid": params.ownerUID,
//        ]
//
//        if let thumbnailURL = params.thumbnailURL {
//            messageDict["thumbnailUrl"] = thumbnailURL
//        }
//        if let thumbnailWidth = params.thumbnailWidth {
//            messageDict["thumbnailWidth"] = thumbnailWidth
//        }
//        if let thumbnailHeight = params.thumbnailHeight {
//            messageDict["thumbnailHeight"] = thumbnailHeight
//        }
//        
//        print("Sending media message with data: \(messageDict)")
//
//        FirebaseConstants.ChannelsRef.child(channel.id).updateChildValues(channelDict) { error, _ in
//            if let error = error {
//                print("Failed to update channel: \(error)")
//                return
//            }
//            FirebaseConstants.MessagesRef.child(channel.id).child(messageId).setValue(messageDict) { error, _ in
//                if let error = error {
//                    print("Failed to send media message: \(error)")
//                    return
//                }
//                completion()
//            }
//        }
//    }
//
//    static func getMessages(for channel: ChannelItem, completion: @escaping ([MessageItem]) -> Void) {
//        FirebaseConstants.MessagesRef.child(channel.id).observe(.value) { snapshot in
//            var messages: [MessageItem] = []
//            for child in snapshot.children {
//                if let childSnapshot = child as? DataSnapshot,
//                   let messageDict = childSnapshot.value as? [String: Any] {
//                    print("Fetched message data: \(messageDict)")
//                    let message = MessageItem(id: childSnapshot.key, isGroupChat: channel.isGroupChat, dict: messageDict)
//                    messages.append(message)
//                }
//            }
//            messages.sort { $0.timeStamp < $1.timeStamp }
//            completion(messages)
//        } withCancel: { error in
//            print("Failed to get messages: \(channel.title), error: \(error)")
//        }
//    }
//}
//
//struct MessageUploadParams {
//    let channel: ChannelItem
//    let text: String
//    let type: MessageType
//    let attachment: MediaAttachment
//    var thumbnailURL: String?
//    var videoURL: String?
//    var sender: UserItem
//    var audioURL: String?
//    var audioDuration: TimeInterval?
//
//    var ownerUID: String {
//        return sender.uid
//    }
//
//    var thumbnailWidth: CGFloat? {
//        guard type == .photo || type == .video else { return nil }
//        return attachment.thumbnail.size.width
//    }
//
//    var thumbnailHeight: CGFloat? {
//        guard type == .photo || type == .video else { return nil }
//        return attachment.thumbnail.size.height
//    }
//}

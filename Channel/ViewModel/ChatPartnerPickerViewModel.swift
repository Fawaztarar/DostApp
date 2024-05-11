//
//  ChatPartnerPickerViewModel.swift
//  WhatsApp
//
//  Created by Fawaz Tarar on 08/05/2024.
//

import Foundation
import Firebase

enum ChannelCreationRoute {
   case groupPartnerPicker
   case setupGroupChat
}

enum ChannelContants {
    static let maxGroupMembers = 256
}

enum ChannelCreationError: Error {
    case noChatPartner
    case failedToCreateUniqueIds 
}

@MainActor 
final class ChatPartnerPickerViewModel: ObservableObject {
      @Published var navStack = [ChannelCreationRoute]()
      @Published var selectedChatPartners = [UserItem]()
      @Published private(set) var users = [UserItem]()
      private var lastCursor: String?

      var showSelectedUsers: Bool {
          return !selectedChatPartners.isEmpty
      }

      var disableNextButton: Bool {
          return selectedChatPartners.isEmpty
      }

      var isPaginatable: Bool {
          return !users.isEmpty
      }

      private var isDirectChannel: Bool {
          return selectedChatPartners.count == 1
      } 

      init() {
          Task {
              await fetchUsers()
          }
      }
     
    func fetchUsers() async {
        do {
            let userNode = try await UserService.paginateUsers(lastCursor: lastCursor, pageSize: 5)
            var fetchedUsers = userNode.users
            guard let currentUid = Auth.auth().currentUser?.uid else { return }
            fetchedUsers = fetchedUsers.filter { $0.uid != currentUid }
            self.users.append(contentsOf: fetchedUsers)
            self.lastCursor = userNode.currentCursor
            
            print("lastCursor: \(String(describing: lastCursor)) \(users.count)")

        } catch {
            print("Error fetching users: \(error.localizedDescription)")
        }
    }



      func handleItemSelection(_ item: UserItem) {
          if isUserSelected(item) {
             guard let index = selectedChatPartners.firstIndex(where: { $0.uid == item.uid }) else { return }
               selectedChatPartners.remove(at: index)
            } else {
               selectedChatPartners.append(item)
            }
      }

      func isUserSelected(_ user: UserItem) -> Bool {
          let isSelected = selectedChatPartners.contains { $0.uid == user.uid }
            return isSelected
      }
      
    

    func createChannel(_ channelName: String?) ->  Result<ChannelItem, Error> {
        guard !selectedChatPartners.isEmpty else {
            return .failure(ChannelCreationError.noChatPartner)
        }
        guard
            let channelId = FirebaseConstants.ChannelsRef.childByAutoId().key,
            let currentUid = Auth.auth().currentUser?.uid
            // let messageId = FirebaseConstants.MessagesRef.childByAutoId().key

        else {  return .failure(ChannelCreationError.failedToCreateUniqueIds) }

        let timeStamp = Date().timeIntervalSince1970
        var membersUids = selectedChatPartners.compactMap { $0.uid }
        membersUids.append(currentUid)

        var channelDict: [String: Any] = [
            .id: channelId,
            .lastMessage: "",
            .creationDate: timeStamp,
            .lastMessageTimeStamp: timeStamp,
            .membersUids: membersUids,
            .membersCount: membersUids.count,
            .adminUids: [currentUid],
        ]

        if let channelName = channelName, !channelName.isEmptyOrWhitespace {
            channelDict[.name] = channelName
        }

        FirebaseConstants.ChannelsRef.child(channelId).setValue(channelDict)

        membersUids.forEach { userId in
            FirebaseConstants.UserChannelRef.child(userId).child(channelId).setValue(true)  
        }

        if isDirectChannel {
            let chatPartner = selectedChatPartners[0]
            FirebaseConstants.UserDirectChannels.child(currentUid).child(chatPartner.uid).setValue([channelId: true])
            FirebaseConstants.UserDirectChannels.child(chatPartner.uid).child(currentUid).setValue([channelId: true])
        }

        var newChannelItem = ChannelItem(channelDict)
        newChannelItem.members = selectedChatPartners
         return .success(newChannelItem)

    }
}


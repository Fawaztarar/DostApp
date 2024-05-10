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
      
    
}

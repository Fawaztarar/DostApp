//
//  ChatPartnerPickerViewModel.swift
//  WhatsApp
//
//  Created by Fawaz Tarar on 08/05/2024.
//

import Foundation

enum ChannelCreationRoute {
   case groupPartnerPicker
   case setupGroupChat
}

enum ChannelContants {
    static let maxGroupMembers = 256
}

final class ChatPartnerPickerViewModel: ObservableObject {
      @Published var navStack = [ChannelCreationRoute]()
      @Published var selectedChatPartners = [UserItem]()

      var showSelectedUsers: Bool {
          return !selectedChatPartners.isEmpty
      }

      var disableNextButton: Bool {
          return selectedChatPartners.isEmpty
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


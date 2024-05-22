//
//  ChatRoomViewModel.swift
//  WhatsApp
//
//  Created by Fawaz Tarar on 14/05/2024.
//

import Foundation
import Combine  

final class ChatRoomViewModel: ObservableObject {
        @Published var textMessage = ""
        @Published var messages = [MessageItem]()

        private(set) var channel: ChannelItem
        private var subscriptions = Set<AnyCancellable>()
        private var currentUser: UserItem?

        init(_ channel: ChannelItem) {
            self.channel = channel
            listenToAuthState()
        }

        deinit {
            subscriptions.forEach { $0.cancel() }
            subscriptions.removeAll()
            currentUser = nil
        }

        private func listenToAuthState() {
            // Listen to auth state
            AuthManager.shared.authState.receive(on: DispatchQueue.main).sink {[weak self] authState in
                guard let self = self else { return }
                    switch authState {
                    case .loggedIn(let currentUser):
                        self.currentUser = currentUser
                        
                        if self.channel.allMembersFetched {
                            self.getMessages()
                            print("channel m embers: \(channel.members.map{ $0.username})")
                        } else {
                            self.getAllChannelMembers()
                        }
                    default:
                        break
                    }
                }.store(in: &subscriptions)
        }

        func sendMessage() {
            guard let currentUser else { return }
            MessageService.sendTextMessage(to: channel, from: currentUser, textMessage) {
                [weak self] in
                self?.textMessage = ""
               
            }
        }
        private func getMessages() {
            MessageService.getMessages(for: channel) {[weak self] messages in
                self?.messages = messages
                print ("messages: \(messages.map { $0.text })")
            }
        }
    
    private func getAllChannelMembers() {
        // I already have the current user, and potentially other members so no need to refetch those
        guard let currentUser = currentUser else { return }
        
        let membersAlreadyFetched = channel.members.compactMap { $0.uid }
        var memberUIDsToFetch = channel.membersUids.filter { !membersAlreadyFetched.contains($0) }
        memberUIDsToFetch = memberUIDsToFetch.filter { $0 != currentUser.uid}
        
        UserService.getUsers(with: memberUIDsToFetch) { [weak self] userNode in
            guard let self = self else { return }
            self.channel.members.append(contentsOf: userNode.users) 
            self.getMessages()
            print("getAllChannelMembers: \(channel.members.map{ $0.username})")
        }
    }

}

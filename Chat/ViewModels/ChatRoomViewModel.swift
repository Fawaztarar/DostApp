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
        private let channel: ChannelItem
        private var subscriptions = Set<AnyCancellable>()


        @Published var currentUser: UserItem?

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
            AuthManager.shared.authState
                .receive(on: DispatchQueue.main)
                .sink { authState in
                    switch authState {
                    case .loggedIn(let currentUser):
                        self.currentUser = currentUser
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
                // print("MessageService is sending")
            }
            // print("textMessage: \(textMessage)")
        }
}
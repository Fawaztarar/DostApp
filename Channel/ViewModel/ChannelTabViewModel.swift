//
//  ChannelTabViewModel.swift
//  WhatsApp
//
//  Created by Fawaz Tarar on 10/05/2024.
//

import Foundation

final class ChannelTabViewModel: ObservableObject {
    
    @Published var navigateToChatRoom = false
    @Published var newChannel: ChannelItem?
    @Published var showChatPartnerPickerView = false

    func onNewChannelCreation(_ channel: ChannelItem) {
        showChatPartnerPickerView = false
        newChannel = channel 
        navigateToChatRoom = true
    } 
}

//
//  ChatPartnerRowView.swift
//  WhatsApp
//
//  Created by Fawaz Tarar on 08/05/2024.
//

import SwiftUI

struct ChatPartnerRowView<Content: View>: View {
    private let user: UserItem
    private let trailingItems : Content

    init(user: UserItem, @ViewBuilder trailingItems: () -> Content = { EmptyView() }) {
        self.user = user
        self.trailingItems = trailingItems()
    }
    
    var body: some View {
        HStack {
            CircularProfileImageView(user.profileImageUrl, size: .xSmall)
                
            
            VStack(alignment: .leading) {
                Text(user.username)
                    .bold()
                    .foregroundStyle(.whatsAppBlack)

                Text(user.bioUnwrapped)
                    .font(.caption)
                    .foregroundStyle(.gray)
                
            }
            trailingItems
           
        }
            
    }
}

#Preview {
    ChatPartnerRowView(user: .placeholder) 
}

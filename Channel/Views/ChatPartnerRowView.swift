//
//  ChatPartnerRowView.swift
//  WhatsApp
//
//  Created by Fawaz Tarar on 08/05/2024.
//

import SwiftUI

struct ChatPartnerRowView: View {
    let user: UserItem
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Circle()
                .frame(width: 40, height: 40)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(user.username)
                    .bold()
                    .foregroundStyle(.whatsAppBlack)

                Text(user.bioUnwrapped)
                    .font(.caption)
                    .foregroundStyle(.gray)
                
            }
            }
                
        }
}

#Preview {
    ChatPartnerRowView(user: .placeholder)
}

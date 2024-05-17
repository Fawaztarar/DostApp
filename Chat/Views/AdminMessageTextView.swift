//
//  AdminMessageTextView.swift
//  WhatsApp
//
//  Created by Fawaz Tarar on 17/05/2024.
//

import SwiftUI

struct AdminMessageTextView: View {
    let channel: ChannelItem
    
    var body: some View {
        VStack {
            if channel.isCreatedByMe {
                textView("You created this group. Tap to add\nmembers")
            } else {
                textView("\(channel.creatorName) created this group.")
                textView("\(channel.creatorName) added you to this group.")
            }
        }
    }
    
    private func textView(_ text: String) -> some View {
        Text(text)
            .multilineTextAlignment(.center)
            .font(.footnote)
            .padding(8)
            .padding(.horizontal, -5)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            .shadow(color: Color(.systemGray3).opacity(0.1), radius: 5, x: 0, y: 20)
    }
}




#Preview {
    ZStack {
        Color.gray.opacity(0.2)
        AdminMessageTextView(channel: ChannelItem.placeholder)
    }
    .ignoresSafeArea()
}

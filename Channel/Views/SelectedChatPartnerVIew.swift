//
//  SelectedChatPartnerVIew.swift
//  WhatsApp
//
//  Created by Fawaz Tarar on 09/05/2024.
//

import SwiftUI

struct SelectedChatPartnerVIew: View {
    let users: [UserItem]
    let onTapped: (_ user: UserItem) -> Void 

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(users) { item in
                    ChatPartnerView(item)
                }
            }
            .padding()
        }
    }

    private func ChatPartnerView(_ user: UserItem) -> some View {
        VStack {
            Circle()
                .fill(Color(.systemGray4))
                .frame(width: 60, height: 60)
                .overlay(alignment: .topTrailing) {
                    cancelButton(user)
                }

            
            Text(user.username)
                .bold()
                .foregroundStyle(.whatsAppBlack)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
        }
    }
    private func cancelButton(_ user: UserItem  ) -> some View {
        Button {
            onTapped(user)
        } label: {
            Image(systemName: "xmark")
                .imageScale(.small)
               
                .foregroundStyle(.white)
                .fontWeight(.semibold)
                .padding(5)
                .background(Color(.systemGray2))
                .clipShape(Circle())
                
        }
    }
}

#Preview {
    SelectedChatPartnerVIew(users: UserItem.placeholders){ user in
         }
}

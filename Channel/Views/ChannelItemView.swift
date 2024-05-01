 //
//  ChannelItemView.swift
//  WhatsApp
//
//  Created by Fawaz Tarar on 01/05/2024.
//

import SwiftUI

struct ChannelItemView: View {
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Circle()
                .frame(width: 60, height: 60)
            
            VStack(alignment: .leading, spacing: 5) {
                titleTextVeiw()
                lastMessagePreview()
                
            }
                
        }
    }

private func titleTextVeiw() -> some View {
    HStack {
        Text("User Name")
            .lineLimit(1)
            .bold()

        Spacer()

        Text("5:00 PM")
            .font(.system(size: 15))
            .foregroundStyle(.gray)
        }

    }
private func lastMessagePreview() -> some View {
    Text("Last message preview")
        .lineLimit(2)
        .foregroundStyle(.gray)
        .font(.system(size: 16))
}
}
#Preview {
    ChannelItemView()
}

//
//  ChannelCreationTextView.swift
//  WhatsApp
//
//  Created by Fawaz Tarar on 17/05/2024.
//

import SwiftUI

struct ChannelCreationTextView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    private var backgroundColor: Color {
        return colorScheme == .dark ? Color.black : Color.yellow
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Text(Image(systemName: "lock.fill"))
                + Text(" پیغامات اور کالز اینڈ ٹو اینڈ انکرپٹڈ ہیں۔ اس گفتگو کے باہر کوئی بھی، یہاں تک کہ دوستی بھی، انہیں پڑھ یا سن نہیں سکتا")
                + Text(" Learn more.")
                .bold()
        }
        .font(.footnote)
        .padding(10)
        .frame(maxWidth: .infinity)
        .background(backgroundColor.opacity(0.6))
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        .padding(.horizontal, 30)
    }
}

#Preview {
    ChannelCreationTextView()
}


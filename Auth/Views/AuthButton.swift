//
//  AuthButton.swift
//  WhatsApp
//
//  Created by Fawaz Tarar on 07/05/2024.
//

import SwiftUI

struct AuthButton: View {
    let title: String
    let onTap:  () -> Void
    
    @Environment(\.isEnabled) private var isEnabled
    
    private var backgroundColor: Color {
        return isEnabled ? Color.white : Color.white.opacity(0.3)
    }
    
    private var textColor: Color {
        return isEnabled ? Color.green : Color.white
    }
    
    var body: some View {
        Button {
            onTap() 
        } label: {
            HStack {
                Text(title)
                
                Image(systemName: "arrow.right")
            }
            .font(.headline)
            .foregroundStyle(textColor)
            .padding()
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
            .shadow(color: .green.opacity(0.2) ,radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            .padding(.horizontal, 32)
        }
    }
}

#Preview {
    ZStack {
        Color.teal
        AuthButton(title: "Login ") {
        }
        
    }
}

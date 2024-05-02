//
//  BubbleTailView.swift
//  WhatsApp
//
//  Created by Fawaz Tarar on 02/05/2024.
//

import SwiftUI

struct BubbleTailView: View {
    var direction: MessageDirection

    private var backgroundColor: Color {
        return direction == .received ? .bubbleWhite : .bubbleGreen
    }
    
    var body: some View {
        Image(direction == .sent ? .outgoingTail : .incomingTail)
            .renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
            .resizable()
            .frame(width: 10, height: 10)
            .offset(y:3)
            .foregroundColor(backgroundColor)
            
            
    }
}
 
#Preview {
    ScrollView{
        BubbleTailView(direction: .sent)
        BubbleTailView(direction: .received)
     }
     .background(Color.gray)

}

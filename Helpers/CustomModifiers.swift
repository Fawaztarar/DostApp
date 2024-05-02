//
//  CustomModifiers.swift
//  WhatsApp
//
//  Created by Fawaz Tarar on 02/05/2024.
//

import Foundation
import SwiftUI

private struct BubbleTailModifier: ViewModifier {
    var direction: MessageDirection
    
   func body(content: Content) -> some View {
        content
            .overlay(
                alignment: direction == .received ? .bottomLeading : .bottomTrailing) {
                BubbleTailView(direction: direction)  
    }
    
}
}

extension View {
    func applyTail(_ direction: MessageDirection) -> some View {
        self.modifier(BubbleTailModifier(direction: direction))
    }
} 

//
//  MessageListView.swift
//  WhatsApp
//
//  Created by Fawaz Tarar on 02/05/2024.
//

import SwiftUI

struct MessageListView: UIViewControllerRepresentable {
    typealias UIViewControllerType = MessageListController

    func makeUIViewController(context: Context) -> MessageListController {
        let messageListController = MessageListController()
        return messageListController
    }

    func updateUIViewController(_ uiViewController: MessageListController, context: Context) {
        // Implement any updates you want to make to the UIViewController
    }
}

#Preview {
    MessageListView()
//    .frame(maxWidth: .infinity)
////    .padding(.horizontal)
//    .background(Color.gray.opacity(0.4))
     
}

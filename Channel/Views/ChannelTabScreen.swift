//
//  ChannelTabScreen.swift
//  WhatsApp
//
//  Created by Fawaz Tarar on 01/05/2024.
//

import SwiftUI

struct ChannelTabScreen: View {
    @State private var searchText = ""
    @State private var showChatPartnerPickerView = false

    var body: some View {
        NavigationView {
            List {
                archiveButton()
                 
                ForEach(0..<12) { _ in
                    NavigationLink {
                        ChatRoomScreen()
                    } label: {
                        ChannelItemView()
                    }
                }
                footerview()
                .listRowSeparator(.hidden)
            }
            .navigationTitle("Chats")
            .searchable(text: $searchText)
            .listStyle(.plain)
            .toolbar {
                leadingNavItem()
                trailingNavItem()
            }
            .sheet(isPresented: $showChatPartnerPickerView) {
                ChatPartnerPickerScreen()
            }
                           
        }
    }
}


extension ChannelTabScreen {
    @ToolbarContentBuilder
    private func leadingNavItem() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Menu {
                Button {
                    // Add your action here
                } label: {
                    Label("Select Chats", systemImage: "checkmark.circle")
                }
                
            } label: {
                Image(systemName: "ellipsis.circle")
            }
        }
    }
}

extension ChannelTabScreen {
    @ToolbarContentBuilder
     private func trailingNavItem() -> some ToolbarContent {
        ToolbarItemGroup(placement: .topBarTrailing) {
            aiButton()
            cameraButton() 
            newChatButton()
            
        }
    }
    private func aiButton() -> some View {
        Button {
        } label: {
            Image(.circle)
        }
    }
 
    private func newChatButton() -> some View {
        Button {
            showChatPartnerPickerView = true
        } label: {
            Image(.plus)
        }
    }


    private func cameraButton() -> some View {
        Button {
            } label: {
                Image(systemName: "camera")
            }
    }

    private func archiveButton() -> some View {
        Button {
            } label: {
                Label("Archive", systemImage: "archivebox.fill") 
                    .bold()  
                    .padding()
                    .foregroundStyle(.gray)
            }
    }

    private func footerview() -> some View {
        HStack {
            Image(systemName: "lock.fill")
                .padding(8)
            Text("Your messages are ")
                .foregroundColor(.gray)
        
            +
            Text("end-to-end encrypted.")
                .foregroundColor(.blue)
               
        }
    }

}

#Preview {
    ChannelTabScreen()
}

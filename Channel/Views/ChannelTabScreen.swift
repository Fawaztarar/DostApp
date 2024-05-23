//
//  ChannelTabScreen.swift
//  WhatsApp
//
//  Created by Fawaz Tarar on 01/05/2024.
//

import SwiftUI

struct ChannelTabScreen: View {
    @State private var searchText = ""
    @StateObject private var viewModel: ChannelTabViewModel
    
    init(_ currentUser: UserItem) {
        self._viewModel = StateObject(wrappedValue: ChannelTabViewModel(currentUser))
        
    }

    var body: some View {
        NavigationStack(path: $viewModel.navRoutes) {
            List {
                archiveButton()
                 
                ForEach(viewModel.channels ) { channel in
                    Button {
                        viewModel.navRoutes.append(.chatRoom(channel))
                    } label: {
                        ChannelItemView(channel: channel)
                    }
                }
                
                footerview()
                .listRowSeparator(.hidden)
            }
            .navigationTitle("گفتگو")
            .searchable(text: $searchText)
            .listStyle(.plain)
            .toolbar {
                leadingNavItem()
                trailingNavItem()
            }
            .navigationDestination(for: ChannelTabRoutes.self) { route in
                destinationView(for: route)
            }
            .sheet(isPresented: $viewModel.showChatPartnerPickerView) {
                ChatPartnerPickerScreen(onCreate: viewModel.onNewChannelCreation)
            }
            .navigationDestination(isPresented:
                 $viewModel.navigateToChatRoom) {
                 if let newChannel = viewModel.newChannel {
                    ChatRoomScreen(channel: newChannel)
                }
             }
        }
    }
}

extension ChannelTabScreen {
    
    @ViewBuilder
    private func destinationView(for route: ChannelTabRoutes) -> some View {
        switch route {
        case .chatRoom (let channel):
            ChatRoomScreen(channel: channel)
        }
    }
    
    
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
            viewModel.showChatPartnerPickerView = true
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
            Text("آپ کے پیغامات")
                .foregroundColor(.gray)
        
            +
            Text("مکمل طور پر رمز کردہ ہیں")
                .foregroundColor(.blue)
                
               
        }
    }

}

#Preview {
    ChannelTabScreen(.placeholder )
}

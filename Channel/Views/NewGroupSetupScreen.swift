//
//  NewGroupSetupScreen.swift
//  WhatsApp
//
//  Created by Fawaz Tarar on 09/05/2024.
//

import SwiftUI

struct NewGroupSetupScreen: View {
    @State private var ChannelName = ""
    @ObservedObject var viewModel = ChatPartnerPickerViewModel()

    var body: some View {
        List {
            Section{
                channelSetUpHeaderView()    
            }
            
            Section {
                Text("Disappearing Messages")
                Text("Group Permissions")     
            }
            Section {
                SelectedChatPartnerVIew(users: UserItem.placeholders) { user in
                    viewModel.handleItemSelection(user)
                } 

            } header: {
                Text("Participants: 10/10 ")
                .bold()
            }
            .listRowBackground(Color.clear)
            
            } 
            
            .navigationTitle("New Group")
            .toolbar {
                trailingNavItem()
        }
    }
    private func channelSetUpHeaderView () -> some View {
        HStack {
            Circle()
            .frame(width: 60, height: 60)

            TextField("",
             text: $ChannelName,
                prompt: Text("Group Name(optional)"),
                axis: .vertical
            )

            
               
        }
    }

@ToolbarContentBuilder

    private func trailingNavItem() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button("Create"){

            }
                .bold()
                .disabled(viewModel.disableNextButton) 

            }
        }
    }



#Preview {
    NavigationStack {
        NewGroupSetupScreen(viewModel: ChatPartnerPickerViewModel())
    }
}

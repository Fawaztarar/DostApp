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

    var onCreate: (_ newChannel: ChannelItem) -> Void

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
                SelectedChatPartnerVIew(users: viewModel.selectedChatPartners) { user in
                    viewModel.handleItemSelection(user)
                } 

            } header: {
                let count = viewModel.selectedChatPartners.count
                let maxCount = ChannelContants.maxGroupMembers
 
                Text("Participants: \(count) of \(maxCount) ")
                .bold()
            }
            .listRowBackground(Color.clear)
            
            } 
            
            .navigationTitle("یا گروپ")
            .toolbar {
                trailingNavItem()
        }
    }
    private func channelSetUpHeaderView () -> some View {
        HStack {
            profileImageView()

            TextField("",
             text: $ChannelName,
                prompt: Text("نیا گروپ (اختیاری)"),
                axis: .vertical
            )    
        }
    }

    private func profileImageView() -> some View {
        Button {
            // Add your action here
        } label: {
            ZStack {
                Image(systemName: "camera.fill")
                    .imageScale(.large)
            }
            .frame(width: 60, height: 60)
            .background(Color(.systemGray6))
            .clipShape(Circle())
               
        }
    }

@ToolbarContentBuilder

    private func trailingNavItem() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button("Create"){
                viewModel.createGroupChannel(ChannelName, completion: onCreate)
            }
                .bold()
                .disabled(viewModel.disableNextButton) 

            }
        }
    }



#Preview {
    NavigationStack {
        NewGroupSetupScreen(viewModel: ChatPartnerPickerViewModel()) { _ in }
    }
}

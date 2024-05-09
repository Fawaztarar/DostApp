//
//  GroupPartnerPickerScreen.swift
//  WhatsApp
//
//  Created by Fawaz Tarar on 09/05/2024.
//


import SwiftUI

struct GroupPartnerPickerScreen: View {
    @ObservedObject var viewModel: ChatPartnerPickerViewModel
    
    @State private var searchText = ""

    var body: some View {
        List {
            if viewModel.showSelectedUsers {
                SelectedChatPartnerVIew(users: viewModel.selectedChatPartners) { 
                    user in
                    viewModel.handleItemSelection(user)
                    }
            }
            
            Section {
                ForEach(UserItem.placeholders) { item in
                    Button {
                        viewModel.handleItemSelection(item)
                    } label: {
                        ChatPartnerRowView(item)
                    }
                }
          
            }
            
        }
        .animation(.easeInOut, value: viewModel.selectedChatPartners)
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search name or number")
        .toolbar {
            titleView()
            trailingNavItem()
        }
    }

    private func ChatPartnerRowView(_ user: UserItem) -> some View {
        WhatsApp.ChatPartnerRowView(user: user) {
            Spacer()
            
            let isSelected = viewModel.isUserSelected(user)
            let imageName = isSelected ? "checkmark.circle.fill" : "circle"
            let foregroundStyle = isSelected ? Color(.systemBlue) : Color(.systemGray4)

            Image(systemName: imageName)
                .foregroundStyle(foregroundStyle)
                .imageScale(.large)
        }
        
    }

}

extension GroupPartnerPickerScreen {
    @ToolbarContentBuilder
    private func titleView() -> some ToolbarContent {
        ToolbarItem(placement: .principal) {
            VStack {
                Text("Add Participants") 
                    .bold()

                let count = viewModel.selectedChatPartners.count
                let maxCount = ChannelContants.maxGroupMembers

                Text("\(count) / \(maxCount) selected")
                    .foregroundStyle(.gray)
                    .font(.footnote)
            }
        }
    }
    @ToolbarContentBuilder 
    private func trailingNavItem() -> some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button("Next") {
                viewModel.navStack.append(.setupGroupChat)
            }
            .bold()
            .disabled(viewModel.disableNextButton)
        }
    }
}

#Preview {
    NavigationStack {
        GroupPartnerPickerScreen(viewModel: ChatPartnerPickerViewModel())
    }
}

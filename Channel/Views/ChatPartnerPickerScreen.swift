//
//  ChatPartnerPickerScreen.swift
//  WhatsApp
//
//  Created by Fawaz Tarar on 08/05/2024.
//

import SwiftUI

struct ChatPartnerPickerScreen: View {
    @State private var searchText = ""
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            List {
                ForEach(ChatPartnerPickerOption.allCases) { item in
                    HeaderItemView(item: item)
                }
                Section {
                    ForEach(0..<12) { _ in
                        ChatPartnerRowView(user: .placeholder) 
                    }
                } header : {
                    Text("Contacts on xWhatsApp")
                        .textCase(.none)
                        .bold() 
                }
            }
            .searchable(text: $searchText, prompt: "Search name or number")
            .navigationTitle( "New Chat")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                trailingNavItem()
            }
        }
        
    }
}
 
extension ChatPartnerPickerScreen {
    @ToolbarContentBuilder
    private func trailingNavItem() -> some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            cancelButton()
            
        }
    }

    private func cancelButton() -> some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
                .font(.footnote)
                .bold()
                .foregroundStyle(.gray)
                .padding(8)
                .background(Color(.systemGray5))
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                
        }
    }

}

extension ChatPartnerPickerScreen {
    private struct HeaderItemView: View {
        let item: ChatPartnerPickerOption

        var body: some View {
            Button  {
               
            } label: {
                buttonBody()
            }
        }
        private func buttonBody() -> some View {
            HStack {
                Image(systemName: item.ImageName)
                    .font(.footnote)
                    .frame(width: 40, height: 40)
                    .background(Color(.systemGray6))
                    .clipShape(Circle())

                Text(item.title)
                                        
            }
        }
           
    }
}

enum ChatPartnerPickerOption: String, CaseIterable, Identifiable {
    case newGroup = "New Group"
     case newContact = "New Contact"
    case newCommunity = "New Community"

    var id: String { 
        return rawValue 
    }

    var title: String {
        return rawValue
    }

    var ImageName: String {
        switch self {
        case .newGroup:
            return "person.2.fill"
        case .newContact:
            return "person.fill.badge.plus"
        case .newCommunity:
            return "person.3"
        }
    }
     
}

#Preview {
    ChatPartnerPickerScreen()
}

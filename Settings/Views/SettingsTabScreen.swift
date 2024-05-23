//
//  SettingsTabScreen.swift
//  WhatsApp
//
//  Created by Fawaz Tarar on 01/05/2024.
//

import SwiftUI

struct SettingsTabScreen: View {
    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            List {
                SettingsHeaderView()
                
                Section {
                    SettingsItemView(item: .broadCastList)
                    SettingsItemView(item: .starredMessages)
                    SettingsItemView(item: .linkedDevices)
                }

                Section {
                    SettingsItemView(item: .account)
                    SettingsItemView(item: .privacy)
                    SettingsItemView(item: .chats)
                    SettingsItemView(item: .notifications)
                    SettingsItemView(item: .storage)

                }
                Section {
                    SettingsItemView(item: .help)
                    SettingsItemView(item: .inviteAFriend)
                    
                    }
                }
                .navigationTitle("ترتیبات")
                .searchable(text: $searchText)
                .toolbar {
                    leadingNavItem() 
                    
                    }
                
            }
        }
}

    extension SettingsTabScreen {
        @ToolbarContentBuilder
        private func  leadingNavItem () -> some ToolbarContent {
            ToolbarItem(placement: .topBarLeading) {
                Button("Sign Out") {  
                    Task {
                        try? await AuthManager.shared.logOut()
                    }
                } 
               
                .foregroundStyle(.red)
            }
        }  
}
  
  private struct SettingsHeaderView: View {
    var body: some View {
        Section {
            HStack {
                Circle()
                    .frame(width: 55, height: 55)
                    
                userInfoTextView()      
            }
            SettingsItemView(item: .avatar)
        }
     }

     private func userInfoTextView() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("فواز تراڑ")
                    .font(.title2)
                    
                Spacer()

                Image(.qrcode)
                    .renderingMode(.template)
                    .background(Color(.systemGray6))
                    .foregroundStyle(.blue)
                    .padding(5)
                    .clipShape(Circle())

                
            }
            Text("میں  دوست ایپ پر دستیاب ہوں۔")
                .font(.callout)
                .foregroundStyle(.gray)
     }
}
  }



#Preview {
    SettingsTabScreen()
}

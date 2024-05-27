//
//  CallsTabScreen.swift
//  WhatsApp
//
//  Created by Fawaz Tarar on 22/05/2024.
//

import SwiftUI

struct CallsTabScreen: View {

    @State private var searchText = ""
    @State private var callHistory = CallHistory.all

    var body: some View {
        NavigationStack {
            List {
                Section {
                    createCallLinkSection()
                }
                
                Section {
                    ForEach(0..<10) { _ in
                        RecentCallItemView()
                    }
                }   header: {
                     Text("حالیہ")
                            .textCase(nil)
                            .foregroundColor(.whatsAppBlack)
                            .font(.headline)
                            .bold()
                   
                 }
            }
            .navigationTitle("کالز")
            .searchable(text:   $searchText)
            .toolbar {
                leadingNavItem()
                trailingNavItem()
                principalNavItem()
            }
            
        }
    }
}

extension CallsTabScreen {
    @ToolbarContentBuilder
    private func trailingNavItem() -> some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button(action: {
               
            }) {
                Image(systemName: "phone.arrow.up.right.fill")
            }
        }
    }

    @ToolbarContentBuilder
    private func leadingNavItem() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button("Edit") {}
        }
    }


    @ToolbarContentBuilder
    private func principalNavItem() -> some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Picker("", selection: $callHistory) {
                ForEach(CallHistory.allCases) { item in
                Text(item.rawValue.capitalized)
                    .tag(item)
                 }
            }
            .pickerStyle(.segmented)
            .frame(width: 150)
        }
    }
        


        private enum CallHistory: String, CaseIterable, Identifiable {
            case all, missed

            var id: String {
                return rawValue
            }
        }

    }
 
        
private func createCallLinkSection() -> some View {
    HStack {
        Image(systemName: "link")
            .padding(8)
            .foregroundColor(.blue)
            .background(Color(.systemGray6))
            .clipShape(Circle())
    
    VStack(alignment: .leading) {
        Text("Create Call Link")
            .foregroundColor(.blue)
        Text("Share a link to start a call")
            .font(.caption)
            .foregroundColor(.gray)
    }
}
}

// priv func RecentCallItemvView() -> some View {
private func RecentCallItemView() -> some View {
    HStack {
        Circle()
            .frame(width: 50, height: 50)
        
        RecentCallsTextView()

        Spacer()

        Text("Yesterday")
            .font(.system(size: 16))
            .foregroundStyle(.gray)

        Image(systemName: "info.circle")
            
        
        
    }
}
 private func RecentCallsTextView() -> some View {
    VStack(alignment: .leading) {
            Text("فواز تارڑ")
                
            HStack {
                Image(systemName: "phone.arrow.up.right.fill")
                    
                Text("Outgoing")
                    
            }
            .font(.system(size: 14))
            .foregroundStyle(.gray)

    }
 }
    


#Preview {
    CallsTabScreen()
}


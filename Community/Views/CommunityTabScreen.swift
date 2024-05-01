//
//  CommunityTabScreen.swift
//  WhatsApp
//
//  Created by Fawaz Tarar on 01/05/2024.
//

import SwiftUI

struct CommunityTabScreen: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    Image(.communities)
                    Group {
                        Text("Stay Connected with Community")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.whatsAppBlack)
                            .padding(.top, 10)

                        Text("Communities bring members together in topic based groups. Any community you join will appear here.")
                         
                            .foregroundColor(.gray)
                                 
                    } .padding(.horizontal, 5)

                    CreateNewCommunityButton()
                        
                    
                    
                        
           
            }
            .padding()
            .navigationTitle("Communities")

             
            }
            
        }
    }}

    private func CreateNewCommunityButton() -> some View {
        Button {

        } label: {
            Label("New Community", systemImage: "plus")
                .bold()
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(10)
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        }
    }

#Preview {
    CommunityTabScreen()
}

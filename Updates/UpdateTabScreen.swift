//
//  UpdateTabScreen.swift
//  WhatsApp
//
//  Created by Fawaz Tarar on 30/04/2024.
//

import SwiftUI

struct UpdateTabScreen: View {
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            List {
                StatusSectionHeader()
                    .listRowBackground(Color.clear)
                
                StatusSectionView()

                Section {
                    RecentUpdatesItemView()
                } header: {
                    Text("تازہ ترین معلومات")
                }
                

                Section {
                    ChannelListView()
                } header: {
                    ChannelSectionHeader()
                       
                    
                    
                }

            }  
            .listStyle(.grouped)
            .navigationTitle("معلومات")
            .searchable(text: $searchText)
        }
    }
    private func ChannelSectionHeader() -> some View {
        HStack {
            Text("چینلز")
                .font(.title3)
                .bold()
                .foregroundColor(.whatsAppBlack)
                .textCase(.none)

            Spacer()

            Button {
                // Handle see all button action
            } label: {
                Image(systemName: "plus")
                    .padding(7)
                    .background(Color(.systemGray5))
                    .clipShape(Circle())
            }
    }
    }
}
// Constants definition using proper Swift convention
extension UpdateTabScreen {
    enum Constant {
        static let imageDimen: CGFloat = 55
    }

    
}

struct StatusSectionHeader: View {
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: "circle.dashed")
                .foregroundStyle(.blue)
                .imageScale(.large)
            
            (
                Text("آپ متن، تصاویر، ویڈیوز اور GIFs شیئر کر سکتے ہیں جو 24 گھنٹوں بعد غائب ہو جاتے ہیں۔")
                +
                Text("  ")
                +
                Text("Status Privacy")
                    .foregroundStyle(.blue).bold()
                
            )
            Image(systemName: "xmark")
                .foregroundStyle(.gray)
        }
        .padding()
        .background(.whatsAppWhite)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

// in HStack add camerabutton and pencilbutton with private functions
struct StatusSectionView: View {
    var body: some View {
        
        HStack {
            Circle()
                .frame(width: UpdateTabScreen.Constant.imageDimen, height: UpdateTabScreen.Constant.imageDimen)

            VStack(alignment: .leading) {
                Text("My Status")
                    .font(.callout)
                    .bold()
                Text("Add to my status")
                    .foregroundStyle(.gray)
                    .font(.system(size: 15))
            }
            Spacer()
            
            cameraButton()
            pencilButton()
        }
    }
    
    private func cameraButton() -> some View {
        Button(action: {
            // Handle camera button action
        }) {
            Image(systemName: "camera.fill")
                .padding(10)
                .background(Color(.systemGray5))
                .clipShape(Circle())
                .bold()
        }
    }
    
    private func pencilButton() -> some View {
        Button(action: {
            // Handle pencil button action
        }) {
            Image(systemName: "pencil")
                .padding(10)
                .background(Color(.systemGray5))
                .clipShape(Circle())
                .bold()
        }
    }
} 

struct RecentUpdatesItemView: View {
    var body: some View {
        HStack {
            Circle()
//                .frame(width: 55, height: 55)
                .frame(width: UpdateTabScreen.Constant.imageDimen, height: UpdateTabScreen.Constant.imageDimen)
            
            VStack(alignment: .leading) {
                Text("فواز تارڑ")
                    .font(.callout)
                    .bold()
                Text("گھنٹہ پہلے")
                    .foregroundStyle(.gray)
                    .font(.system(size: 15))
            }
        }
    }
}
struct ChannelListView: View {
    var body: some View {
        HStack {
            Text("ان موضوعات پر تازہ ترین معلومات حاصل کریں جو آپ کے لیے اہم ہیں")
                .font(.callout)
                .padding(.horizontal)
                .foregroundColor(.gray)}
        VStack {

                // add Scrollview with horizontal not show indicator for ChannelItemView
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<5) { _ in
                        SuggestedChannelItemView()
                    }
                }
            }
            
        }
    }
}

struct SuggestedChannelItemView: View {
    var body: some View {
        VStack {
            Circle()
                .frame(width: UpdateTabScreen.Constant.imageDimen, height: UpdateTabScreen.Constant.imageDimen)
            
            
            Text("خبریں پاکستان")
                    .font(.callout)
                    .bold()
            
            Button {
                // Handle follow button action
            } label: {
                Text("پیروی کریں")
                    .bold()
                    .padding(5)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue.opacity(0.2))
                    .clipShape(Capsule())
                    
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.systemGray6), lineWidth: 1)
        )
    }
}

#Preview {
    UpdateTabScreen()
}






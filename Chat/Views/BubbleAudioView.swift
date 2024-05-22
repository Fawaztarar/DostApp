//
//  BubbleAudioView.swift
//  WhatsApp
//
//  Created by Fawaz Tarar on 03/05/2024.
//

import SwiftUI

struct BubbleAudioView: View {
    let item: MessageItem
    @State private var slideValue: Double = 0
    @State private var sliderRange: ClosedRange<Double> = 0...20

    var body: some View {
        HStack(alignment: .bottom, spacing: 5) {
            
            if item.showGroupPartnerInfo {
                CircularProfileImageView(item.sender?.profileImageUrl, size: .mini)
                    .offset(y :5)
            }
            if item.direction == .sent {
                timeStampTextView()
            }
            
            HStack {
            playButton()
            Slider(value: $slideValue , in: sliderRange)
                .tint(.gray)

            Text("06:00")
                .foregroundStyle(.gray)

        }
        .padding(10)
        .background(Color.gray.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .padding(5)
        .background(item.backgroundColor )
        .clipShape(RoundedRectangle(cornerRadius: 16, style:  .continuous))
        .applyTail(item.direction )
            
        if item.direction == .received {
            timeStampTextView()
        }
    }
    .shadow(color: Color(.systemGray3).opacity(0.1), radius: 5, x: 0, y: 20)
    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: item.alignment)
    .padding(.leading, item.leadingPadding)
    .padding(.trailing, item.trailingPadding)
        
        }

    private func playButton() -> some View {
            Button {
            
            } label: {
            Image(systemName: "play")
                .padding(10)
                .background(item.direction == .received ? .green : .white)
                .clipShape(Circle())
                .foregroundStyle(item.direction == .received ? .white : .black)
         }
    }
    
    private func timeStampTextView() -> some View {
            Text("12:05 PM")
                .font(.footnote)
                .foregroundStyle(.gray)
    }
}

#Preview {
    ScrollView {
    BubbleAudioView(item: .sentPlaceholder)
    BubbleAudioView(item: .receivedPlaceholder)
}
    .frame(maxWidth: .infinity)
    .padding(.horizontal)
    .background(Color.gray.opacity(0.4))
    .onAppear {
        let thumbImage = UIImage(systemName: "circle.fill")
        UISlider.appearance().setThumbImage(thumbImage, for: .normal)
    } 

}


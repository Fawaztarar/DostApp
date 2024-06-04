//
//  TextInputArea.swift
//  WhatsApp
//
//  Created by Fawaz Tarar on 02/05/2024.
//

import SwiftUI

struct TextInputArea: View {
    @Binding var textMessage: String
    let actionHandler: (_ action: UserAction) -> Void
    @State private var isRecording = false
    @State private var isPulsing = false

    private var disableSendButton: Bool {
        return textMessage.isEmptyOrWhitespace || isRecording
    }

    var body: some View {
        HStack(alignment: .bottom,spacing: 5 ){
            imagePickerButton()
                .padding(3)
            audioRecorderButton()
            if isRecording {
                audioSessionIndicatorView()
            } else {
                messsageTextField()
            }
            
            sendMessageButton()
                .disabled(disableSendButton)
                .grayscale(disableSendButton ? 0.8 : 0)

        }
        .padding(.bottom)
        .padding(.horizontal, 8)
        .padding(.top,10)
        .background(.whatsAppWhite)
        .animation(.spring, value: isRecording)
        
    }
    private func audioSessionIndicatorView() -> some View {
        HStack {
            Image(systemName: "circle.fill")
                .foregroundStyle(.red)
                .font(.caption)
                .scaleEffect(isPulsing ? 1.8 : 1.0)
            
            Text("Recording Audio")
                .font(.caption)
                .lineLimit(1)
            
            Spacer()
            
            Text("00.01")
                .font(.callout)
                .fontWeight(.semibold)
        }
        .padding(.horizontal, 8)
        .frame(height: 30)
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .clipShape(Capsule())
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.blue.opacity(0.1))
        )
        .overlay(textViewBorder())
    }
    
private func messsageTextField() -> some View {
    TextField("", text: $textMessage , axis: .vertical)
        .padding(5)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(.thinMaterial)
        )
        .overlay(textViewBorder())
        
}
private func textViewBorder() -> some View {
    RoundedRectangle(cornerRadius: 20, style: .continuous)
        .stroke(Color(.systemGray5), lineWidth: 1)  
}


private func imagePickerButton() -> some View {
    Button {
        actionHandler(.presentPhotoPicker)
    } label: {
        Image(systemName: "photo.on.rectangle")
            .font(.system(size: 22))
    }
}

private func audioRecorderButton() -> some View {
    Button {
        actionHandler(.recordAudio)
        isRecording.toggle()
        withAnimation(.easeInOut(duration :1.5).repeatForever()) {
            isPulsing.toggle()
        }
        
    } label: {
        Image(systemName: isRecording ? "square.fill" : "mic.fill")
            .fontWeight(.heavy)
            .foregroundStyle(.white)
            .padding(6)
            .background(isRecording ? .red : .blue)
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
    }
}
private func sendMessageButton() -> some View {
    Button {
        actionHandler(.sendMessage)
        
    } label: {
        Image(systemName: "arrow.up")
            .fontWeight(.heavy)
            .foregroundStyle(.white)
            .padding(6)
            .background(Color.blue)
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            
        }
    }

}

extension TextInputArea{
    enum UserAction {
        case presentPhotoPicker
        case sendMessage
        case recordAudio
        
    }
}

#Preview {
    TextInputArea(textMessage: .constant("")) {_ in 
        
    }
}

//
//  LoginScreen.swift
//  WhatsApp
//
//  Created by Fawaz Tarar on 07/05/2024.
//

import SwiftUI

struct LoginScreen: View {
    @StateObject private var authScreenModel = AuthScreenModel()

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                AuthHeaderView()
                
                AuthTextField(type: .email,  text: $authScreenModel.email)
                AuthTextField(type: .password,  text: $authScreenModel.password) 
                
                forgotPasswordButton()
                
                AuthButton(title: "Log In Now"){
                    Task {
                        await authScreenModel.handleLogin()
                    } 
                    
                }
                .disabled(authScreenModel.disableLoginButton)
                
                Spacer() 
                
                SignUpButton()
                    .padding(.bottom, 30)
                 
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
            .background{
                LinearGradient(
                    gradient: Gradient(colors: [.green, Color.green.opacity(0.8), .teal]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            }
            .ignoresSafeArea()
            .alert(isPresented: $authScreenModel.errorState.showError) {
                Alert(title: Text(authScreenModel.errorState.errorMessage), dismissButton: .default(Text("OK"))
                )
                
            }
        }
    }
    private func forgotPasswordButton() -> some View {
        Button {
            
        } label: {
             Text("پاس ورڈ بھول گئے؟")
                .foregroundStyle(.white)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .trailing)
                .padding(.trailing, 32)
                .bold()
                .padding(.vertical) 
        }
    }
    
    private func SignUpButton() -> some View {
        NavigationLink {
            SignUpScreen(authScreenModel: authScreenModel) 
        } label: {
            HStack {
                Image(systemName: "sparkles")
                (
                    Text("کیا آپ کا اکاؤنٹ نہیں ہے ؟")
                    +
                    Text("ایک بنائیں").bold()
                )
                Image(systemName: "sparkles")
            }
            .foregroundStyle(.white)
        }
    }
}

#Preview {
    LoginScreen()
}

//
//  LoginScreen.swift
//  WhatsApp
//
//  Created by Fawaz Tarar on 07/05/2024.
//

import SwiftUI

struct LoginScreen: View {
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                AuthHeaderView()
                
                AuthTextField(type: .email,  text: .constant(""))
                AuthTextField(type: .password,  text: .constant(""))
                
                forgotPasswordButton()
                
                AuthButton(title: "Login Now"){
                    
                }
                
                Spacer() 
                
                SignUpButton()
                    .padding(.bottom, 30)
                 
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
            .background(Color.teal.gradient)
            .ignoresSafeArea() 
        }
    }
    private func forgotPasswordButton() -> some View {
        Button {
            
        } label: {
             Text("Forget Password ?")
                .foregroundStyle(.white)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .trailing)
                .padding(.trailing, 32)
                .bold()
                .padding(.vertical) 
        }
    }
    
    private func SignUpButton() -> some View {
        NavigationLink {
            Text("Sign Up View")
        } label: {
            HStack {
                Image(systemName: "sparkles")
                (
                    Text("Dont Have an account ? ")
                    +
                    Text("Create one").bold()
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

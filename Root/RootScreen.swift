//
//  RootScreen.swift
//  WhatsApp
//
//  Created by Fawaz Tarar on 07/05/2024.
//

import SwiftUI

struct RootScreen: View {
    @StateObject private var viewModel = RootScreenModel()

    var body: some View {
        switch viewModel.authState {
        case .pending:
            ProgressView()
                .controlSize(.large)


        case .loggedIn(_):
            MainTabView()

        case .loggedOut: 
            LoginScreen()   
        }
    }
}

#Preview {
    RootScreen()
}

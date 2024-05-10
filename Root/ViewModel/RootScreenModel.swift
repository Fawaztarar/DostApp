//
//  RootScreenModel.swift
//  WhatsApp
//
//  Created by Fawaz Tarar on 07/05/2024.
//

import Foundation
import Combine

final class RootScreenModel: ObservableObject {
    
    @Published private(set) var authState = AuthState.pending
    private var cancellable: AnyCancellable?
    
    init() {
        cancellable = AuthManager.shared.authState.receive(on: DispatchQueue.main)
        .sink {[weak self] latestAuthState in
            self?.authState = latestAuthState
        }

        
    }
    // private func registerTestAccount(with email: String) {
    //     Task {
    //         let username = email.replacingOccurrences(of: "@test.com", with: "")
    //         try? await AuthManager.shared.createAccount(for: username, with: email, and: "12345678")
    //     }
    // }
    
    
} 
 

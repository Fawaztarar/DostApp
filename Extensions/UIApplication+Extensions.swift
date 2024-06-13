//
//  UIApplication+Extensions.swift
//  WhatsApp
//
//  Created by Fawaz Tarar on 12/06/2024.
//

import UIKit

extension UIApplication {
    static func dismissKeyBoard() {
        UIApplication
            .shared
            .sendAction(#selector(UIApplication.resignFirstResponder), to:nil, from: nil, for:nil)
    }
    
}

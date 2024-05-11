//
//  String+Extensions.swift
//  WhatsApp
//
//  Created by Fawaz Tarar on 11/05/2024.
//

import Foundation

extension String {
    var isEmptyOrWhitespace: Bool {
        return trimmingCharacters(in: .whitespaces).isEmpty
    }
}

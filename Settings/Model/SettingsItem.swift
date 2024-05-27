//
//  SettingsItem.swift
//  WhatsApp
//
//  Created by Fawaz Tarar on 01/05/2024.
//

import Foundation
import SwiftUI

struct SettingsItem {
    let imageName: String
    var imageType: ImageType = .systemImage
    let backgroundColor: Color
    let title: String

    enum ImageType {
        case systemImage, assetImage
    }
}

//MARK: Settings Data

extension SettingsItem {
    static let avatar = SettingsItem(
        imageName: "photo", 
        backgroundColor: .black,
        title: "پروفائل تصویر تبدیل کریں"
        )
  
    
    static let broadCastList = SettingsItem(
        imageName: "megaphone.fill", 
        backgroundColor: .black,
        title: "Broadcast List"
        )
    

    static let starredMessages = SettingsItem(
        imageName: "star.fill", 
        backgroundColor: .black,
        title: "Starred Messages"
        )

    static let linkedDevices = SettingsItem(
        imageName: "laptopcomputer", 
        backgroundColor: .black,
        title: "Linked Devices"
        )
    
    static let account = SettingsItem(
        imageName: "key.fill", 
        backgroundColor: .black,
        title: "Account"
        )

    static let privacy = SettingsItem(
        imageName: "lock.fill", 
        backgroundColor: .black,
        title: "رازداری"
        )

    
    static let chats = SettingsItem(
        imageName: "whatsapp-black", 
        imageType: .assetImage,
        backgroundColor: .black,
        title: "گفتگو"
        )
    
    static let notifications = SettingsItem(
        imageName: "bell.badge.fill", 
        backgroundColor: .black,
        title: "اطلاعات"
        )

    static let storage = SettingsItem(
        imageName: "arrow.up.arrow.down", 
        backgroundColor: .black,
        title: "Storage and Data"
        )
    
    static let help = SettingsItem(
        imageName: "info", 
        backgroundColor: .black,
        title: "مدد"
        )
    
    static let inviteAFriend = SettingsItem(
        imageName: "heart.fill", 
        backgroundColor: .black,
        title: "Invite a Friend"
        )
    

    static let media = SettingsItem(
        imageName: "photo.fill.on.rectangle.fill", 
        backgroundColor: .black,
        title: "Media, Links, and Docs"
        )

    static let mute = SettingsItem(
        imageName: "speaker.wave.2.fill", 
        backgroundColor: .black,
        title: "Mute"
        )

    static let wallpaper = SettingsItem(
        imageName: "circle.hexagongrid.fill", 
        backgroundColor: .black,
        title: "Wallpaper"
        )

    static let saveToCameraRoll = SettingsItem(
        imageName: "square.and.arrow.down",
        backgroundColor: .black,
        title: "Save to Camera Roll"
        )
    
    static let encryption  = SettingsItem(
        imageName: "lock.fill", 
        backgroundColor: .black,
        title: "Encryption"
        )

    static let disappearingmessages = SettingsItem(
        imageName: "timer", 
        backgroundColor: .black,
        title: "Disappearing Messages"
        )

    static let lockChat = SettingsItem(
        imageName: "lock.doc.fill", 
        backgroundColor: .black,
        title: "Lock Chat"
        )

    static let contactDetails = SettingsItem(
        imageName: "person.circle", 
        backgroundColor: .black, 
        title: "رابطے کی تفصیلات"
        )
    static let signOut = SettingsItem(
            imageName: "arrow.right.square.fill",
            backgroundColor: .red,
            title: "Sign Out"
        )
}

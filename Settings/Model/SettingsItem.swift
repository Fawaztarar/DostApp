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
        backgroundColor: .blue, 
        title: "پروفائل تصویر تبدیل کریں"
        )
  
    
    static let broadCastList = SettingsItem(
        imageName: "megaphone.fill", 
        backgroundColor: .green, 
        title: "Broadcast List"
        )
    

    static let starredMessages = SettingsItem(
        imageName: "star.fill", 
        backgroundColor: .yellow, 
        title: "Starred Messages"
        )

    static let linkedDevices = SettingsItem(
        imageName: "laptopcomputer", 
        backgroundColor: .green, 
        title: "Linked Devices"
        )
    
    static let account = SettingsItem(
        imageName: "key.fill", 
        backgroundColor: .blue, 
        title: "Account"
        )

    static let privacy = SettingsItem(
        imageName: "lock.fill", 
        backgroundColor: .blue, 
        title: "رازداری"
        )

    
    static let chats = SettingsItem(
        imageName: "whatsapp-black", 
        imageType: .assetImage,
        backgroundColor: .green, 
        title: "گفتگو"
        )
    
    static let notifications = SettingsItem(
        imageName: "bell.badge.fill", 
        backgroundColor: .red, 
        title: "اطلاعات"
        )

    static let storage = SettingsItem(
        imageName: "arrow.up.arrow.down", 
        backgroundColor: .green, 
        title: "Storage and Data"
        )
    
    static let help = SettingsItem(
        imageName: "info", 
        backgroundColor: .blue, 
        title: "مدد"
        )
    
    static let inviteAFriend = SettingsItem(
        imageName: "heart.fill", 
        backgroundColor: .red, 
        title: "Invite a Friend"
        )
    

    static let media = SettingsItem(
        imageName: "photo.fill.on.rectangle.fill", 
        backgroundColor: .green, 
        title: "Media, Links, and Docs"
        )

    static let mute = SettingsItem(
        imageName: "speaker.wave.2.fill", 
        backgroundColor: .green, 
        title: "Mute"
        )

    static let wallpaper = SettingsItem(
        imageName: "circle.hexagongrid.fill", 
        backgroundColor: .mint, 
        title: "Wallpaper"
        )

    static let saveToCameraRoll = SettingsItem(
        imageName: "square.and.arrow.down",
        backgroundColor: .yellow,
        title: "Save to Camera Roll"
        )
    
    static let encryption  = SettingsItem(
        imageName: "lock.fill", 
        backgroundColor: .blue, 
        title: "Encryption"
        )

    static let disappearingmessages = SettingsItem(
        imageName: "timer", 
        backgroundColor: .green, 
        title: "Disappearing Messages"
        )

    static let lockChat = SettingsItem(
        imageName: "lock.doc.fill", 
        backgroundColor: .blue, 
        title: "Lock Chat"
        )

    static let contactDetails = SettingsItem(
        imageName: "person.circle", 
        backgroundColor: .gray, 
        title: "رابطے کی تفصیلات"
        )
}

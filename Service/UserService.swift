//
//  UserService.swift
//  WhatsApp
//
//  Created by Fawaz Tarar on 10/05/2024.
//


import Foundation
import Firebase
import FirebaseDatabase

struct UserService{

    static func paginateUsers(lastCursor: String?, pageSize: UInt) async throws -> UserNode  {
        let mainSnapshot: DataSnapshot
        if lastCursor == nil {
            mainSnapshot = try await FirebaseConstants.UserRef.queryLimited(toLast: pageSize).getData()
        } else {
            mainSnapshot = try await FirebaseConstants.UserRef
                .queryOrderedByKey()
                .queryEnding(atValue: lastCursor)
                .queryLimited(toLast: pageSize + 1)
                .getData()
        }
        guard let first = mainSnapshot.children.allObjects.first as? DataSnapshot,
              let allObjects = mainSnapshot.children.allObjects as? [DataSnapshot] else {
                  return .emptyNode
              }

        let users: [UserItem] = allObjects.compactMap { userSnapshot in
            let UserDict = userSnapshot.value as? [String: Any] ?? [:]
            return UserItem(dictionary: UserDict)
        }

        if users.count  == mainSnapshot.childrenCount {
            let filteredUsers = lastCursor == nil ? users : users.filter { $0.uid != lastCursor }
            let userNode = UserNode(users: filteredUsers, currentCursor: first.key)
            return userNode
        }
        
        return .emptyNode

    }
}

struct UserNode {
    var users: [UserItem]
    var currentCursor: String?
    static let emptyNode = UserNode(users: [], currentCursor: nil)
}



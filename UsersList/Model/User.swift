//
//  User.swift
//  UsersList
//
//  Created by Mohammad Zulqurnain on 26/05/2024.
//

import Foundation

struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let email: String
}

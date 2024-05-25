//
//  Actions.swift
//  UsersList
//
//  Created by Mohammad Zulqurnain on 26/05/2024.
//

import Foundation

enum AppAction {
    case fetchUsers
    case fetchUsersSuccess([User])
    case fetchUsersFailure(String)
}

//
//  AppState.swift
//  UsersList
//
//  Created by Mohammad Zulqurnain on 26/05/2024.
//

import Combine

struct AppState {
    var users: [User] = []
    var isLoading: Bool = false
    var errorMessage: String?
}

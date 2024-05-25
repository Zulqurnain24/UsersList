//
//  UsersListApp.swift
//  UsersList
//
//  Created by Mohammad Zulqurnain on 26/05/2024.
//

import SwiftUI

@main
struct UsersListApp: App {
    var body: some Scene {
        WindowGroup {
            UserListView(store: Store(initialState: AppState(), reducer: appReducer(state:action:)))
        }
    }
}

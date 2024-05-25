//
//  appReducer.swift
//  UsersList
//
//  Created by Mohammad Zulqurnain on 26/05/2024.
//

func appReducer(state: inout AppState, action: AppAction) -> Void {
    switch action {
    case .fetchUsers:
        state.isLoading = true
        state.errorMessage = nil
    case .fetchUsersSuccess(let users):
        state.isLoading = false
        state.users = users
    case .fetchUsersFailure(let errorMessage):
        state.isLoading = false
        state.errorMessage = errorMessage
    }
}

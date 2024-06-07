//
//  ContentView.swift
//  UsersList
//
//  Created by Mohammad Zulqurnain on 26/05/2024.
//

import SwiftUI

struct UserListView: View {
    @StateObject var store: Store
  
    var body: some View {
        NavigationView {
            VStack {
                if store.state.isLoading {
                    ProgressView()
                } else if let errorMessage = store.state.errorMessage {
                    Text(errorMessage)
                } else {
                    List(store.state.users) { user in
                        VStack(alignment: .leading) {
                            Text(user.name)
                                .font(.headline)
                            Text(user.email)
                                .font(.subheadline)
                        }
                    }
                }
            }
            .navigationTitle("Users")
            .task { @MainActor in
                bindState()
                appReducer(state: &store.state, action: .fetchUsers)
            }
        }
    }

    fileprivate func bindState() {
        store.bind(repository: UserRepositoryImpl())
    }
}





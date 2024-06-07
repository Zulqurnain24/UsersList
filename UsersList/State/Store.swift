//
//  Store.swift
//  UsersList
//
//  Created by Mohammad Zulqurnain on 26/05/2024.
//

import Combine
import Foundation

class Store: ObservableObject {
    @Published var state: AppState

    private let reducer: (inout AppState, AppAction) -> Void
    private var cancellables: Set<AnyCancellable> = []

    init(initialState: AppState, reducer: @escaping (inout AppState, AppAction) -> Void) {
        self.state = initialState
        self.reducer = reducer
    }

    func send(_ action: AppAction) {
        reducer(&state, action)
    }

    func bind(repository: UserRepository) {
        repository.fetchUsers()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.send(.fetchUsersFailure(error.localizedDescription))
                case .finished:
                    break
                }
            }, receiveValue: { users in
                self.send(.fetchUsersSuccess(users))
            })
            .store(in: &cancellables)
    }
}


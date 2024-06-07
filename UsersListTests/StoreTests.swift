//
//  StoreTests.swift
//  UsersListTests
//
//  Created by Mohammad Zulqurnain on 26/05/2024.
//

import XCTest
import Combine
import UsersList

class StoreTests: XCTestCase {
    var store: Store!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        store = Store(initialState: AppState(), reducer: appReducer)
        store.bind(repository: UserRepositoryImpl())
        cancellables = []
    }

    func testFetchUsersSuccess() {
        let expectation = XCTestExpectation(description: "Fetch users success")

        store.$state
            .dropFirst()
            .sink { state in
                if state.errorMessage == nil,
                    !state.users.isEmpty {
                    XCTAssertFalse(state.isLoading)
                    XCTAssertEqual(state.users.count, 1)
                    XCTAssertNil(state.errorMessage)
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        appReducer(state: &store.state, action: .fetchUsers)
        appReducer(state: &store.state, action: .fetchUsersSuccess([User(id: 1, name: "John Doe", email: "john.doe@example.com")]))

        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchUsersFailure() {
        let expectation = XCTestExpectation(description: "Fetch users failure")

        store.$state
            .dropFirst()
            .sink { state in
                if !(state.errorMessage?.isEmpty ?? true) {
                    XCTAssertFalse(state.isLoading)
                    XCTAssertEqual(state.users.count, 0)
                    XCTAssertNotNil(state.errorMessage)
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        appReducer(state: &store.state, action: .fetchUsers)
        appReducer(state: &store.state, action: .fetchUsersFailure("Network Error"))

        wait(for: [expectation], timeout: 1.0)
    }
}


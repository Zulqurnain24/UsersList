//
//  UserRepositoryTests.swift
//  UsersListTests
//
//  Created by Mohammad Zulqurnain on 26/05/2024.
//

import Combine
import XCTest
import UsersList

class UserRepositoryTests: XCTestCase {
    var repository: UserRepository!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        repository = UserRepositoryImpl()
        cancellables = []
    }

    func testFetchUsers() {
        let expectation = XCTestExpectation(description: "Fetch users from network")

        repository.fetchUsers()
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    XCTFail("Failed to fetch users")
                }
            }, receiveValue: { users in
                XCTAssertGreaterThan(users.count, 0)
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }
}


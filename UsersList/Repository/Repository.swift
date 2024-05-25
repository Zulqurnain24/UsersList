//
//  Repository.swift
//  UsersList
//
//  Created by Mohammad Zulqurnain on 26/05/2024.
//

import Combine
import Foundation

protocol UserRepository {
    func fetchUsers() -> AnyPublisher<[User], Error>
}

class UserRepositoryImpl: UserRepository {
    private let url = URL(string: "https://jsonplaceholder.typicode.com/users")!

    func fetchUsers() -> AnyPublisher<[User], Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [User].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}


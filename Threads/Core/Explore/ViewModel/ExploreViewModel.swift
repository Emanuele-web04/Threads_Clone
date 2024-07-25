//
//  ExploreViewModel.swift
//  Threads
//
//  Created by Emanuele Di Pietro on 25/07/24.
//

import Foundation

class ExploreViewModel: ObservableObject {
    @Published var users = [User]()
    
    init() {
        Task {
            try await fetchUsers()
        }
    }
    
    @MainActor
    private func fetchUsers() async throws {
        //is a static func, you dont need shared
        self.users = try await UserService.fetchUsers()
    }
}

//
//  FeedViewModel.swift
//  Threads
//
//  Created by Emanuele Di Pietro on 25/07/24.
//

import Firebase

@MainActor
class FeedViewModel: ObservableObject {
    @Published var threads = [Thread]()
    
    init() {
        Task { try await fetchThreads() }
    }
    
    func fetchThreads() async throws {
        self.threads = try await ThreadService.fetchThreads()
        try await fetchUserDataForThreads()
    }
    
    private func fetchUserDataForThreads() async throws {
        for i in 0 ..< threads.count {
            let thread = threads[i]
            let ownerUid = thread.ownerUid
            let threadUser = try await UserService.fethUser(withUid: ownerUid)
            
            threads[i].user = threadUser
        }
    }
}

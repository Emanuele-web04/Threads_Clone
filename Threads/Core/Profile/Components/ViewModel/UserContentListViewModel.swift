//
//  UserContentListViewModel.swift
//  Threads
//
//  Created by Emanuele Di Pietro on 26/07/24.
//

import Firebase


class UserContentListViewModel: ObservableObject {
    
    @Published var threads = [Thread]()
    @Published var currentUserLikedThreads = [Thread]()
    @Published var currentUserBookmarkedThreads = [Thread]()
    
    let user: User
    
    init(user: User) {
        self.user = user
        Task {
            try await fetchUserThreads()
            try await fetchUserLikedThreads()
            try await fetchUserBookmarkedThreads()
        }
    }
    
    @MainActor
    func fetchUserThreads() async throws {
        var threads = try await ThreadService.fetchUserThreads(uid: user.id)
        for i in 0 ..< threads.count {
            threads[i].user = self.user
        }
        self.threads = threads
    }
    
    @MainActor
    func fetchUserLikedThreads() async throws {
        var allThreads = try await ThreadService.fetchThreads()
        for i in 0 ..< allThreads.count {
            let thread = allThreads[i]
            let ownerUid = thread.ownerUid
            let threadUser = try await UserService.fethUser(withUid: ownerUid)
            
            allThreads[i].user = threadUser
        }
        self.currentUserLikedThreads = allThreads.filter({ $0.likedIDs.contains(user.id) })
    }
    
    @MainActor
    func fetchUserBookmarkedThreads() async throws {
        var allThreads = try await ThreadService.fetchThreads()
        for i in 0 ..< allThreads.count {
            let thread = allThreads[i]
            let ownerUid = thread.ownerUid
            let threadUser = try await UserService.fethUser(withUid: ownerUid)
            allThreads[i].user = threadUser
        }
        self.currentUserBookmarkedThreads = allThreads.filter({ $0.bookmarkIDs.contains(user.id) })
    }
}

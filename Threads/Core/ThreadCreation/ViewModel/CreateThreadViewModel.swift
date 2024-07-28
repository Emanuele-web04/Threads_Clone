//
//  ThreadViewModel.swift
//  Threads
//
//  Created by Emanuele Di Pietro on 25/07/24.
//

import Firebase

class CreateThreadViewModel: ObservableObject {
    
    func uploadThread(_ caption: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let thread = Thread(ownerUid: uid, caption: caption, timestamp: Timestamp())
        try await ThreadService.uploadThread(thread)
    }
    
}

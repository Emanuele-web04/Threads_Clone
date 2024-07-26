//
//  ThreadCellViewModel.swift
//  Threads
//
//  Created by Emanuele Di Pietro on 26/07/24.
//

import Firebase

@MainActor
class ThreadCellViewModel: ObservableObject {
    
    func likeThread(_ thread: Thread) async throws {
        // if the user has already liked the thread, you remove it, otherwise, you add it into the array
    
        guard let threadID = thread.threadID else { return }
        guard let uid = Auth.auth().currentUser?.uid else { return }
        if thread.likedIDs.contains(uid) {
                try await Firestore.firestore().collection("threads").document(threadID).updateData([
                    "likedIDs" : FieldValue.arrayRemove([uid])
                ])
            } else {
                try await Firestore.firestore().collection("threads").document(threadID).updateData([
                    "likedIDs" : FieldValue.arrayUnion([uid])
                ])
            }
    }
}

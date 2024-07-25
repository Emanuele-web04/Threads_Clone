//
//  Thread.swift
//  Threads
//
//  Created by Emanuele Di Pietro on 25/07/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Thread: Identifiable, Codable {
    @DocumentID var threadID: String?
    let ownerUid: String // pointer to the user that holds the thread
    let caption: String
    let timestamp: Timestamp
    var likes: Int
    var bookmark: Bool
    
    var id: String {
        return threadID ?? UUID().uuidString
    }
    
    var user: User?
}

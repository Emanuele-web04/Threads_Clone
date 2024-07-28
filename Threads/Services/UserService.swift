//
//  UserService.swift
//  Threads
//
//  Created by Emanuele Di Pietro on 25/07/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class UserService {
    @Published var currentUser: User?
    
    static let shared = UserService()
    
    init() {
        Task {
            try await fetchCurrentUser()
        }
    }
    
    @MainActor
    func fetchCurrentUser() async throws {
        // check if exists the uid, if it exists you continue, otherwise the function stops
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        let user = try snapshot.data(as: User.self)
        self.currentUser = user
    }
    
    static func fethUser(withUid uid: String) async throws -> User {
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        return try snapshot.data(as: User.self)
    }
    
    static func fetchUsers() async throws -> [User] {
        guard let currentUid = Auth.auth().currentUser?.uid else { return [] }
        let snapshot = try await Firestore.firestore().collection("users").getDocuments()
        let users = snapshot.documents.compactMap({ try? $0.data(as: User.self) })
        return users.filter({ $0.id != currentUid })
    }
    
    func reset() {
        self.currentUser = nil
    }
    
    @MainActor
    func updateUserProfileImage(withImageURL imageURL: String) async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        try await Firestore.firestore().collection("users").document(currentUid).updateData([ "profileImageUrl" : imageURL ])
        self.currentUser?.profileImageUrl = imageURL
    }
    
    @MainActor
    func updateUserBio(withBio bio: String) async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        try await Firestore.firestore().collection("users").document(currentUid).updateData(["bio" : bio])
        self.currentUser?.bio = bio
    }
    
    @MainActor
    func updateUserLink(withLink link: String) async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        try await Firestore.firestore().collection("users").document(currentUid).updateData(["link" : link])
        self.currentUser?.link = link
    }
    
    @MainActor
    func updateVerifiedState(withVerified isVerified: Bool) async throws {
        // fetch the current user id
        guard let uid = Auth.auth().currentUser?.uid else { return }
        try await Firestore.firestore().collection("users").document(uid).updateData([ "isVerified" : isVerified ])
        self.currentUser?.isVerified = isVerified
    }
}

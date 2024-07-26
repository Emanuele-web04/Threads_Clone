//
//  AuthService.swift
//  Threads
//
//  Created by Emanuele Di Pietro on 25/07/24.
//

import Firebase
import FirebaseStorage
import FirebaseFirestoreSwift

class AuthService {
    
    // passing the shared value in order to have the same shared instances between all the vm and views
    // singleton: one class used in multiples vms because we need all the vms listen to update and update the userSession
    static let shared = AuthService()
    
    @Published var userSession: FirebaseAuth.User?
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    @MainActor
    func login(with email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            // this fetch the user uid and pass it into the currentUser to display
            try await UserService.shared.fetchCurrentUser()
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func createUser(with email: String, password: String, fullname: String, username: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            try await uploadUSerDeta(with: email, fullname: fullname, username: username, id: result.user.uid)
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        try? Auth.auth().signOut() // signs out on the backend
        self.userSession = nil // this removes session locally, because this is called inside the mainview
        UserService.shared.reset() // sets current user object to nil
    }
    
    @MainActor
    private func uploadUSerDeta(with email: String, fullname: String, username: String, id: String) async throws {
        let user = User(id: id, fullname: fullname, email: email, username: username)
        guard let userData = try? Firestore.Encoder().encode(user) else { return }
        try await Firestore.firestore().collection("users").document(id).setData(userData)
        UserService.shared.currentUser = user
    }
    
    private func deleteAccount() async throws {
        // first of all you need to delete the pf image of the user from database
        // so you retrieve the user id and take the image of the user
        guard let userUid = Auth.auth().currentUser?.uid else { return }
        //retrieve the image from userid
        let ref = Storage.storage().reference().child("profile_images").child(userUid)
        try await ref.delete()
        // deleting firestore user document
        try await Firestore.firestore().collection("users").document(userUid).delete()
        // deleting auth account and setting user session to nil
        try await Auth.auth().currentUser?.delete()
        self.userSession = nil
        UserService.shared.reset() // sets current user object to nil
    }
}

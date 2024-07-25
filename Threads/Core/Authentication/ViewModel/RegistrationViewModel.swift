//
//  RegistrationViewModel.swift
//  Threads
//
//  Created by Emanuele Di Pietro on 25/07/24.
//

import Foundation

class RegistrationViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var fullname: String = ""
    @Published var username: String = ""
    
    @MainActor
    func createUser() async throws {
       try await AuthService.shared.createUser(
        with: email,
        password: password,
        fullname: fullname,
        username: username)
    }
}

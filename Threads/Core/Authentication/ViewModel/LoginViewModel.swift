//
//  LoginViewModel.swift
//  Threads
//
//  Created by Emanuele Di Pietro on 25/07/24.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    @MainActor
    func login() async throws {
       try await AuthService.shared.login(
        with: email,
        password: password)
    }
}

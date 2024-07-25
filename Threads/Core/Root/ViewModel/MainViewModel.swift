//
//  MainViewModel.swift
//  Threads
//
//  Created by Emanuele Di Pietro on 25/07/24.
//

import Foundation
import Combine
import Firebase

class MainViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupSubscribers()
    }
    
    private func setupSubscribers() {
        AuthService.shared.$userSession.sink { [weak self] userSession in
            self?.userSession = userSession
        }.store(in: &cancellables)
    }
}

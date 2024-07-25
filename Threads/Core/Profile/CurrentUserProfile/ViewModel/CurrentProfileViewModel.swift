//
//  ProfileViewModel.swift
//  Threads
//
//  Created by Emanuele Di Pietro on 25/07/24.
//

import SwiftUI
import Combine


class CurrentUserProfileViewModel: ObservableObject {
    @Published var currentUser: User?
    private var cancellables = Set<AnyCancellable>()
    
    init() {
       setupSubscribers()
    }
    
    private func setupSubscribers() {
        UserService.shared.$currentUser.sink { [weak self] user in
            self?.currentUser = user
        }.store(in: &cancellables)
    }
}

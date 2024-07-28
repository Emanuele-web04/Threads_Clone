//
//  PreviewProvider.swift
//  Threads
//
//  Created by Emanuele Di Pietro on 25/07/24.
//

import SwiftUI
import Firebase

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.shared
    }
}

class DeveloperPreview {
    static let shared = DeveloperPreview()
    
    let user = User(id: UUID().uuidString, fullname: "Andrew Tate", email: "andrewtate@gmail.com", username: "Cobratate", isVerified: true)
    let thread = Thread(ownerUid: "123", caption: "Women can't drive", timestamp: Timestamp())
}


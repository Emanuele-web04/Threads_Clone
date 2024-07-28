//
//  ProfileThreadFilter.swift
//  Threads
//
//  Created by Emanuele Di Pietro on 24/07/24.
//

import Foundation

enum ProfileThreadFilter: Int, CaseIterable, Identifiable {
    case threads
    case likes
    case bookmarks
    
    var id: Self { return self }
    
    var title: String {
        switch self {
        case .threads:
            "Threads"
        case .likes:
            "Likes"
        case .bookmarks:
            "Bookmarks"
        }
    }
}

//
//  User.swift
//  Threads
//
//  Created by Emanuele Di Pietro on 25/07/24.
//

import Foundation

struct User: Identifiable, Codable, Hashable {
    let id: String
    let fullname: String
    let email: String
    let username: String
    var profileImageUrl: String?
    var bio: String?
    var link: String?
}

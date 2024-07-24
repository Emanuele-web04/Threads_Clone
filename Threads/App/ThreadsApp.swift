//
//  ThreadsApp.swift
//  Threads
//
//  Created by Emanuele Di Pietro on 24/07/24.
//

import SwiftUI

@main
struct ThreadsApp: App {
    var body: some Scene {
        WindowGroup {
            ThreadsTabView()
                .preferredColorScheme(.dark)
        }
    }
}

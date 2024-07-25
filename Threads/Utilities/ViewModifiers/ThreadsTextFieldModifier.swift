//
//  ThreadsTextFieldModifier.swift
//  Threads
//
//  Created by Emanuele Di Pietro on 24/07/24.
//

import SwiftUI

struct ThreadsTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .padding(12)
            .background(RoundedRectangle(cornerRadius: 50).stroke(.white, lineWidth: 0.5))
    }
}


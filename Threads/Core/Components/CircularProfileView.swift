//
//  CircularProfileView.swift
//  Threads
//
//  Created by Emanuele Di Pietro on 24/07/24.
//

import SwiftUI

struct CircularProfileView: View {
    var body: some View {
        Image(systemName: "person.fill").frame(width: 40, height: 40).clipShape(Circle()).background { Circle().fill(.gray)}
    }
}

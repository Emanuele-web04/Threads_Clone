//
//  CircularProfileView.swift
//  Threads
//
//  Created by Emanuele Di Pietro on 24/07/24.
//

import SwiftUI
import Kingfisher

enum ProfileImageSize {
    case xxs
    case xs
    case s
    case m
    case l
    case xl
    
    var dimension: CGFloat {
        switch self {
        case .xxs:
            return 28
        case .xs:
            return 32
        case .s:
            return 40
        case .m:
            return 48
        case .l:
            return 64
        case .xl:
            return 80
        }
    }
}

struct CircularProfileView: View {
    
    var user: User?
    let size: ProfileImageSize
    
    var body: some View {
        if let imageURL = user?.profileImageUrl, let validURL = URL(string: imageURL) {
            KFImage(validURL)
                    .resizable()
                    .scaledToFill()
                    .frame(width: size.dimension, height: size.dimension).clipShape(Circle())
        } else {
            Image(systemName: "person.fill").frame(width: 40, height: 40).clipShape(Circle()).background { Circle().fill(.gray)}
        }
    }
}

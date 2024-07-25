//
//  UserContentListView.swift
//  Threads
//
//  Created by Emanuele Di Pietro on 25/07/24.
//

import SwiftUI

struct UserContentListView: View {
    
    @Namespace var animation
    @State private var selectedFilter: ProfileThreadFilter = .threads
    private var filterBarWidth: CGFloat {
        let count = CGFloat(ProfileThreadFilter.allCases.count)
        return UIScreen.main.bounds.width / count - 20
    }
    
    
    var body: some View {
        VStack {
            HStack {
                ForEach(ProfileThreadFilter.allCases, id: \.id) { filter in
                    VStack {
                        Text(filter.title)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundStyle(selectedFilter == filter ? .white : .gray)
                        
                        ScrollView(.horizontal) {
                            if selectedFilter == filter {
                                Rectangle()
                                    .foregroundStyle(.xBlue)
                                    .frame(width: filterBarWidth, height: 2).matchedGeometryEffect(id: "item", in: animation)
                            } else {
                                Rectangle()
                                    .foregroundStyle(.clear)
                                    .frame(width: filterBarWidth, height: 2)
                            }
                        }
                    }
                    .onTapGesture {
                        withAnimation(.spring()) {
                            selectedFilter = filter
                        }
                    }
                }
            }
            
            LazyVStack {
                ForEach(0 ... 10, id: \.self) { thread in
                    ThreadCell()
                }
            }
        }.padding(.vertical, 8)
    }
}

#Preview {
    UserContentListView()
}

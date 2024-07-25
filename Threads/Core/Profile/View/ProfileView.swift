//
//  ProfileView.swift
//  Threads
//
//  Created by Emanuele Di Pietro on 24/07/24.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var selectedFilter: ProfileThreadFilter = .threads
    @State private var following = 903
    @State private var followers = 9.7
    
    @Namespace var animation
    
    private var filterBarWidth: CGFloat {
        let count = CGFloat(ProfileThreadFilter.allCases.count)
        return UIScreen.main.bounds.width / count - 20
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                //bio
                VStack(spacing: 20) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 25) {
                            //full name
                            HStack {
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    CircularProfileView()
                                    Text("Andrew Tate")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                    Text("@Cobratate")
                                        .foregroundStyle(.gray)
                                        .font(.subheadline)
                                }
                                Spacer()
                                Button {
                                    
                                } label: {
                                    Text("Following")
                                        .font(.footnote)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.white)
                                        .frame(maxWidth: 110)
                                        .padding(6)
                                        .background(RoundedRectangle(cornerRadius: 50).stroke(Color(.systemGray4), lineWidth: 1.5))
                                }
                            }
                            
                            Text("Unmatched perspicacity coupled with sheer indefatigability makes me a feared opponent in every realm of human endevour.")
                                .font(.footnote)
                            HStack(spacing: 10) {
                                HStack(spacing: 3) {
                                    Text("\(following)").fontWeight(.semibold)
                                    Text("Following").foregroundStyle(.gray)
                                }
                                HStack(spacing: 3) {
                                    Text(String(format: "%.1f", followers) + "M").fontWeight(.semibold)
                                    Text("Following").foregroundStyle(.gray)
                                        .foregroundStyle(.gray)
                                }
                            }.font(.footnote)
                            
                        }
                        Spacer(minLength: 0)
                        
                    }
                    
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
                    }
                }
            }.padding(.horizontal, 10)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            AuthService.shared.signOut()
                        } label: {
                            Image(systemName: "arrow.right.to.line.alt").imageScale(.small).padding(10).foregroundStyle(.red)
                                .background(Circle().fill(Color(.systemGray4)))
                        }
                    }
                }
        }
    }
}

#Preview {
    ProfileView()
}

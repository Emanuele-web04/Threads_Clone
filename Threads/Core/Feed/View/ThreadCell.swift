//
//  ThreadCell.swift
//  Threads
//
//  Created by Emanuele Di Pietro on 24/07/24.
//

import SwiftUI

struct ThreadCell: View {
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 12) {
                Image(systemName: "person").frame(width: 40, height: 40).clipShape(Circle()).background { Circle().fill(.gray)}
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text("maxverstappen1")
                            .font(.footnote)
                            .fontWeight(.semibold)
                        Text("•").padding(.bottom, 3)
                            .foregroundStyle(Color(.systemGray2))
                        Text("10m")
                            .font(.caption)
                            .foregroundStyle(Color(.systemGray2))
                        Spacer()
                        Button {
                            
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundStyle(Color(.darkGray))
                        }
                    }
                    
                    Text("Formula 1 champion")
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                    
                    HStack {
                        Button {
                            
                        } label: {
                            Image(systemName: "bubble.left").imageScale(.small)
                        }
                        Spacer()
                        Button {
                            
                        } label: {
                            Image(systemName: "arrow.2.squarepath").imageScale(.small)
                        }
                        Spacer()
                        Button {
                            
                        } label: {
                            Image(systemName: "heart").imageScale(.small)
                        }
                        Spacer()
                        Button {
                            
                        } label: {
                            Image(systemName: "text.alignright").rotationEffect(.degrees(90)).imageScale(.small)
                        }
                        Spacer()
                        Button {
                            
                        } label: {
                            Image(systemName: "bookmark").resizable().frame(width: 10, height: 13)
                        }
                        Spacer()
                        Button {
                            
                        } label: {
                            Image(systemName: "paperplane").imageScale(.small)
                        }
                        
                    }.foregroundStyle(.gray).padding(.vertical, 10)
                }
            }
            Divider()
                .frame(width: 400)
        }.padding()
    }
}

#Preview {
    ThreadCell()
}

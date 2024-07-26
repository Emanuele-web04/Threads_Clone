//
//  ThreadCell.swift
//  Threads
//
//  Created by Emanuele Di Pietro on 24/07/24.
//

import SwiftUI

struct ThreadCell: View {
    
    let thread: Thread
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 12) {
                CircularProfileView(user: thread.user, size: .s)
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(thread.user?.fullname ?? "")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Text("•").padding(.bottom, 3)
                            .foregroundStyle(Color(.systemGray2))
                        Text(thread.timestamp.toString())
                            .font(.footnote)
                            .foregroundStyle(Color(.systemGray2))
                        Spacer()
                        Button {
                            
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundStyle(Color(.darkGray))
                        }
                    }
                    
                    Text(thread.caption)
                        .font(.subheadline)
                        .multilineTextAlignment(.leading)
                    
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
                            Image(systemName: "arrow.up.circle").imageScale(.small)
                        }
                        
                    }.foregroundStyle(.gray).padding(.vertical, 10)
                }
            }
            Divider()
                .frame(width: 400)
        }.padding()
    }
}

//#Preview {
//    ThreadCell()
//}

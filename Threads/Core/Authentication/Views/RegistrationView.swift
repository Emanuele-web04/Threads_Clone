//
//  RegistrationView.swift
//  Threads
//
//  Created by Emanuele Di Pietro on 24/07/24.
//

import SwiftUI

struct RegistrationView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var fullName: String = ""
    @State private var username: String = ""
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            Image("x-twitter").resizable().scaledToFill().frame(width: 70, height: 70)
            VStack(spacing: 20) {
                TextField("Enter your email", text: $email)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .modifier(ThreadsTextFieldModifier())
                SecureField("Enter your password", text: $password)
                    .modifier(ThreadsTextFieldModifier())
                TextField("Enter your full name", text: $fullName)
                    .modifier(ThreadsTextFieldModifier())
                TextField("Enter your username", text: $username)
                    .modifier(ThreadsTextFieldModifier())
                
                Button {
                    
                } label: {
                    Text("Sign up")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.accent).cornerRadius(8)
                }
                
            }
            Spacer()
            
            Divider()
            
            Button {
                dismiss()
            } label: {
                HStack {
                    Text("Already have an account?")
                    Text("Sign In")
                }
                .foregroundStyle(.white)
                .font(.footnote)
                    .fontWeight(.semibold)
            }
        }.padding()
    }
}

#Preview {
    RegistrationView()
}

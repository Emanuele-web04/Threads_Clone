//
//  LoginView.swift
//  Threads
//
//  Created by Emanuele Di Pietro on 24/07/24.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    
    var body: some View {
        NavigationStack {
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
                }
                
                NavigationLink {
                    Text("Forgot Password")
                } label: {
                    Text("Forgot Password?")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .padding(.top)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                
                Spacer()
                Button {
                    
                } label: {
                    Text("Login")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.accent).cornerRadius(8)
                }
                
                Divider()
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack {
                        Text("Don't have an account?")
                        Text("Signup")
                    }
                    .foregroundStyle(.white)
                    .font(.footnote)
                        .fontWeight(.semibold)
                }
                
            }.padding()
        }
    }
}

#Preview {
    LoginView()
}

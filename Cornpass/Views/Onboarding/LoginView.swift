//
//  LoginView.swift
//  Cornpass
//
//  Created by Muhammed Nadeem on 23/05/26.
//

import SwiftUI

struct LoginView: View {

    @State private var viewModel = LoginViewModel()

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack(spacing: 0) {
                Group {
                    Text("Welcome to CornPass")
                        .font(AppFont.semiBold.font(size: 12))
                        .padding(.bottom, 3)
                    Text("Let’s Sign You In! 🍿")
                        .font(AppFont.semiBold.font(size: 18))
                }
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                
                Spacer()
                    .frame(height: 30)
                
                Image(.logoWhite)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 114, height: 92)
                    .padding(.vertical, 30)
                
                // TextField
                VStack(spacing: 16) {
                    CustomTextField(title: "Email", text: $viewModel.email, keyboardType: .emailAddress)
                    CustomTextField(title: "Password", text: $viewModel.password, isSecured: true)
                }
                .padding(.vertical)
                
                HStack {
                    Spacer()
                    Button {
                        print("TODO: Forgot password")
                    } label: {
                        Text("Forgot Password?")
                            .foregroundStyle(.white)
                            .font(AppFont.semiBold.font(size: 14))
                    }
                }
                .padding(.bottom)
                
                // Primary Button
                PrimaryButton(title: "Sign In") {
                    viewModel.validateAndLogin()
                }
                .padding(.top)
                .padding(.bottom, 16)
                // Goole and Facebook
                HStack(spacing: 16) {
                    LoginActionButton(title: "Google", image: .google) {
                        print("TODO: Google action")
                    }
                    LoginActionButton(title: "Facebook", image: .facebook) {
                        print("TODO: Facebook action")
                    }
                }
                .padding(.bottom, 16)
                // Dont have account
                Button {
                    print("TODO: Sign Up Action")
                } label: {
                    HStack(spacing: 3) {
                        Text("Don’t have an account? ")
                            .font(AppFont.regular.font(size: 14))
                        Text("Create one")
                            .font(AppFont.semiBold.font(size: 14))
                    }
                    .foregroundStyle(.white)
                    .padding(.top, 16)
                }
            }
            .padding(.horizontal)
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $viewModel.navigateToGenrePicker) {
            GenrePickerView()
        }
    }
}

@Observable
class LoginViewModel {

    var email: String = ""
    var password: String = ""
    var navigateToGenrePicker: Bool = false

    func validateAndLogin() {
        // Need regex check and show validation errors to the user.
        UserDefaults.standard.setValue(email, forKey: UserDefaultKeys.email.rawValue)
        UserDefaults.standard.setValue(password, forKey: UserDefaultKeys.password.rawValue)
        UserDefaults.standard.setValue(true, forKey: UserDefaultKeys.userLoggedIn.rawValue)
        navigateToGenrePicker = true
    }

}

#Preview {
    LoginView()
}

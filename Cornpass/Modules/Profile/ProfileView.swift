//
//  ProfileView.swift
//  Cornpass
//
//  Created by Muhammed Nadeem on 22/05/26.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack {
            Text("TODO: PROFILE")
            Button {
                UserDefaults.standard.set(false, forKey: UserDefaultKeys.userLoggedIn.rawValue)
            } label: {
                Text("Logout")
                    .foregroundStyle(.red)
            }
        }
        .foregroundStyle(.white)
    }
}

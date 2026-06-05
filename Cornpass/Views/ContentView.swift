//
//  ContentView.swift
//  Cornpass
//
//  Created by Muhammed Nadeem on 22/05/26.
//

import SwiftUI
import Observation

struct ContentView: View {

    @State private var entryManager = AppEntryManager()

    var body: some View {
        NavigationStack {
            Group {
                if entryManager.isUserLoggedIn {
                    TabViewContainer()
                } else {
                    WelcomeView()
                }
            }
            .preferredColorScheme(.dark)
        }
    }
}

@Observable
class AppEntryManager {

    var isUserLoggedIn: Bool {
        UserDefaults.standard.bool(forKey: UserDefaultKeys.userLoggedIn.rawValue)
    }

}

#Preview {
    ContentView()
}


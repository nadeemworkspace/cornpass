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
    @State private var showSplash = true

    var body: some View {
        Group {
            if showSplash {
                SplashView()
            } else {
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
        .task {
            try? await Task.sleep(for: .seconds(3))
            showSplash = false
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


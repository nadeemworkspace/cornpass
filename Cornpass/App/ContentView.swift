//
//  ContentView.swift
//  Cornpass
//
//  Created by Muhammed Nadeem on 22/05/26.
//

import SwiftUI

struct ContentView: View {

    @State private var entryManager = AppEntryManager()
    @State private var showSplash = true

    var body: some View {
        Group {
            if showSplash {
                SplashView()
            } else {
                Group {
                    if entryManager.isUserLoggedIn {
                        // Each tab owns its own NavigationStack (see
                        // TabViewContainer), so no wrapping stack here.
                        TabViewContainer()
                    } else {
                        NavigationStack {
                            WelcomeView()
                        }
                    }
                }
                .preferredColorScheme(.dark)
            }
        }
        .task {
            try? await Task.sleep(for: .seconds(1))
            showSplash = false
        }
    }
}

#Preview {
    ContentView()
}

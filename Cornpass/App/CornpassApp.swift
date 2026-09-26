//
//  CornpassApp.swift
//  Cornpass
//
//  Created by Muhammed Nadeem on 22/05/26.
//

import SwiftUI

@main
struct CornpassApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                // Set here, not just inside ContentView's body, so UIKit's own
                // chrome (nav bar material during a push transition, etc.)
                // picks up dark trait immediately instead of momentarily
                // rendering its default light appearance before SwiftUI's
                // modifier propagates down.
                .preferredColorScheme(.dark)
        }
    }
}

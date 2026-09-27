//
//  AppEntryManager.swift
//  Cornpass
//
//  Created by Muhammed Nadeem on 22/05/26.
//

import Foundation
import Observation

// `.shared` so LoginViewModel/GenrePickerViewModel/ProfileView can flip the
// SAME instance ContentView observes. `isUserLoggedIn` is a real stored,
// observed property (not read fresh from UserDefaults each time) so setting
// it actually swaps ContentView's root — logging in no longer needs to push
// TabViewContainer onto the onboarding NavigationStack, which used to nest
// it inside that stack and break title/toolbar propagation for every tab.
@Observable
class AppEntryManager {

    static let shared = AppEntryManager()

    var isUserLoggedIn: Bool {
        didSet {
            UserDefaults.standard.set(isUserLoggedIn, forKey: UserDefaultKeys.userLoggedIn.rawValue)
        }
    }

    init() {
        isUserLoggedIn = UserDefaults.standard.bool(forKey: UserDefaultKeys.userLoggedIn.rawValue)
    }
}

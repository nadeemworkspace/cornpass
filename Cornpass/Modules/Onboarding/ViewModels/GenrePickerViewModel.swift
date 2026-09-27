//
//  GenrePickerViewModel.swift
//  Cornpass
//
//  Created by Muhammed Nadeem on 22/05/26.
//

import Foundation
import Observation
import SpriteKit

@Observable
class GenrePickerViewModel {

    enum GPAction {
        case skip, save
    }

    var genres: [Genre] = Genre.fallback
    var selectedCount: Int { genres.filter(\.isSelected).count }

    func loadGenres() async {
        if let fetched = try? await MovieRepository.shared.genres(), !fetched.isEmpty {
            genres = fetched
        }
    }

    func finishOnboarding(_ action: GPAction) {
        // Save selected if action is .save
        // Flipping this (rather than pushing TabViewContainer onto this
        // onboarding NavigationStack) lets ContentView swap its whole root,
        // so the tab bar's screens never end up nested inside this stack.
        AppEntryManager.shared.isUserLoggedIn = true
    }

}

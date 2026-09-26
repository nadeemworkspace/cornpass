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
    var navigateToHome: Bool = false

    func loadGenres() async {
        if let fetched = try? await MovieRepository.shared.genres(), !fetched.isEmpty {
            genres = fetched
        }
    }

    func navigateToHome(_ action: GPAction) {
        // Save selected if action is .save
        navigateToHome = true
    }

}

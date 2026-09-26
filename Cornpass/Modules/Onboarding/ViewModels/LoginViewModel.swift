//
//  LoginViewModel.swift
//  Cornpass
//
//  Created by Muhammed Nadeem on 22/05/26.
//

import Foundation
import Observation

@Observable
class LoginViewModel {

    var email: String = ""
    var password: String = ""
    var navigateToGenrePicker: Bool = false

    func validateAndLogin() {
        // Need regex check and show validation errors to the user.
        UserDefaults.standard.setValue(email, forKey: UserDefaultKeys.email.rawValue)
        UserDefaults.standard.setValue(password, forKey: UserDefaultKeys.password.rawValue)
        // Login itself doesn't grant entry — GenrePickerViewModel does that
        // once onboarding finishes, so the app root only ever swaps to
        // TabViewContainer after that step (see AppEntryManager).
        navigateToGenrePicker = true
    }

}

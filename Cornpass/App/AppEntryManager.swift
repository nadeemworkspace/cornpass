//
//  AppEntryManager.swift
//  Cornpass
//
//  Created by Muhammed Nadeem on 22/05/26.
//

import Foundation
import Observation

@Observable
class AppEntryManager {

    var isUserLoggedIn: Bool {
        UserDefaults.standard.bool(forKey: UserDefaultKeys.userLoggedIn.rawValue)
    }

}

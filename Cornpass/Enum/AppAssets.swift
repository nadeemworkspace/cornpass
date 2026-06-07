//
//  AppAssets.swift
//  Cornpass
//
//  Created by Muhammed Nadeem on 23/05/26.
//

import SwiftUI

enum AppFont: String {
    case regular = "SFUIDisplay-Regular"
    case bold = "SFUIDisplay-Bold"
    case medium = "SFUIDisplay-Medium"
    case semiBold = "SFUIDisplay-Semibold"

    func font(size: CGFloat) -> Font {
        .custom(rawValue, size: size)
    }
}

enum TabImage: String {
    case tab_home_fill
    case tab_home
    case tab_feed_fill
    case tab_feed
    case tab_profile_fill
    case tab_profile
    case tab_ticket_fill
    case tab_ticket
}

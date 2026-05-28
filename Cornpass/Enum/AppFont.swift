//
//  AppFont.swift
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

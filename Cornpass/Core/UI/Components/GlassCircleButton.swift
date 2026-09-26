//
//  GlassCircleButton.swift
//  Cornpass
//
//  Reusable Liquid Glass circular icon button. Pair with `GlassSearchField`
//  as the trailing action (clear text, dismiss the search bar, ...).
//

import SwiftUI

struct GlassCircleButton: View {
    let systemImage: String
    var size: CGFloat = 44
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: systemImage)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(.white)
        }
        .buttonStyle(.glass)
        .buttonSizing(.fitted)
        // Circle() fits whatever bounding box it's given, so an unequal
        // width/height renders an ellipse, not a circle — force a square.
        .frame(width: size, height: size)
        .clipShape(Circle())
    }
}

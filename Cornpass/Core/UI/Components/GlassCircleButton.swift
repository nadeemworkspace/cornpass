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
    var size: CGFloat = 40
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: systemImage)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(.white)
                .frame(width: size, height: size)
        }
        .buttonStyle(.glass)
        .buttonSizing(.fitted)
        .clipShape(Circle())
    }
}

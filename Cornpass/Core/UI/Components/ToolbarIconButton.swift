//
//  ToolbarIconButton.swift
//  Cornpass
//
//  A plain SF Symbol button for use inside a `ToolbarItem`. The system's own
//  Liquid Glass toolbar chrome renders this as a proper circle — no custom
//  background, frame or clipShape needed (and none of those compose safely
//  with the toolbar's own sizing, which is what made hand-rolled circular
//  toolbar buttons render as ellipses). For a circular glass button OUTSIDE
//  a toolbar, use `GlassCircleButton` instead.
//

import SwiftUI

struct ToolbarIconButton: View {
    let systemImage: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: systemImage)
        }
    }
}

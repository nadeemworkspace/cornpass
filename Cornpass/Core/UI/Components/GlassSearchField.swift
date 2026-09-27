//
//  GlassSearchField.swift
//  Cornpass
//
//  Created by Muhammed Nadeem on 22/05/26.
//

import SwiftUI

struct GlassSearchField: View {
    let placeholder: String
    @Binding var text: String
    var focus: FocusState<Bool>.Binding?

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.white.opacity(0.7))
                .padding(.leading, 12)
            textField
                .font(AppFont.regular.font(size: 16))
                .foregroundStyle(.white)
                .tint(.white)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .submitLabel(.search)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .glassEffect(.regular, in: .capsule)
    }

    @ViewBuilder
    private var textField: some View {
        if let focus {
            TextField(placeholder, text: $text)
                .focused(focus)
        } else {
            TextField(placeholder, text: $text)
        }
    }
}

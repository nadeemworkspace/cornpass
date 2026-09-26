//
//  MovieLanguageView.swift
//  Cornpass
//
//  Created by Muhammed Nadeem on 22/05/26.
//

import SwiftUI

struct MovieLanguageView: View {
    let language: String
    let accentColor: Color
    var body: some View {
        Text(language)
            .foregroundStyle(accentColor)
            .font(AppFont.bold.font(size: 10))
            .frame(height: 22)
            .padding(.horizontal, 8)
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(accentColor)
            )
            .fixedSize(horizontal: true, vertical: false)
    }
}

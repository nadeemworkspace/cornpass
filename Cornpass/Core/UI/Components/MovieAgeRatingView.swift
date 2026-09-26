//
//  MovieAgeRatingView.swift
//  Cornpass
//
//  Created by Muhammed Nadeem on 22/05/26.
//

import SwiftUI

struct MovieAgeRatingView: View {
    let rating: String
    let forgroundColor: Color
    let backgroundColor: Color

    init(rating: String, forgroundColor: Color = .white, backgroundColor: Color = .gray) {
        self.rating = rating
        self.forgroundColor = forgroundColor
        self.backgroundColor = backgroundColor
    }

    var body: some View {
        Text(rating)
            .foregroundStyle(forgroundColor)
            .font(AppFont.bold.font(size: 10))
            .fixedSize(horizontal: true, vertical: false)
            .frame(height: 22)
            .padding(.horizontal, 8)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .fill(backgroundColor)
            )
            .fixedSize(horizontal: true, vertical: false)
    }
}
